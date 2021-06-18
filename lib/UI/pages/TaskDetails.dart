import 'package:animate_icons/animate_icons.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:tyme/UI/Components/TodoTile.dart';

import 'package:tyme/database/database.dart';
import 'package:tyme/main.dart';
import 'package:tyme/utils/dateUtils.dart';
import 'package:tyme/utils/konstants.dart';

class TaskDetails extends StatefulWidget {
  final Task task;

  const TaskDetails({Key? key, required this.task}) : super(key: key);
  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails>
    with SingleTickerProviderStateMixin {
  final List<FocusNode> _nodes = [];
  late DateTime _selectedDateTime;
  TimeOfDay? _selectedDayTime;
  AnimateIconController controller = AnimateIconController();
  bool isPlaying = false;
  bool firstLoaded = true;
  late bool isDone;
  @override
  void initState() {
    isDone = widget.task.isDone;
    textEditingController.text = widget.task.note;
    _selectedDateTime = widget.task.dueDate;
    _selectedDayTime = TimeOfDay.fromDateTime(widget.task.dueDate);
    super.initState();
  }

  void getNodesNeeded() {
    if (_nodes.length != lastitem) {
      _nodes.clear();
      for (var i = 0; i < lastitem; i++) {
        _nodes.add(FocusNode());
      }
    }
  }

  void removeFocus() {
    _nodes.forEach((element) {
      element.unfocus();
    });
  }

  void handleFocus() {
    // ignore: unnecessary_statements
    if (!firstLoaded && _nodes.isNotEmpty) {
      removeFocus();
      _nodes[lastitem - 1].requestFocus();
    }
  }

  Widget tileLeading(IconData iconData, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            iconData,
            color: AppColors.darkGrey,
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            title,
            style: TextStyle(color: AppColors.darkGrey),
          )
        ],
      ),
    );
  }

  Widget _dueDateWidget() {
    return InkWell(
      onTap: () async {
        _selectedDateTime = await showDatePicker(
                context: context,
                initialDate: _selectedDateTime,
                firstDate: kToday,
                lastDate: kLastDay) ??
            _selectedDateTime;
        await db.updateTask(widget.task.copyWith(dueDate: _selectedDateTime));
        setState(() {});
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tileLeading(Icons.calendar_today_outlined, 'Due Date'),
              Card(
                elevation: 0,
                margin: EdgeInsets.all(8),
                color: AppColors.bleuGrey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    DateFormat('EEE, d/M/y').format(_selectedDateTime),
                    style: TextStyle(color: AppColors.darkGrey),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  TextEditingController textEditingController = TextEditingController();
  Widget _noteWidget() {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            height: 150,
            child: TextField(
              enabled: !isDone,
              controller: textEditingController,
              decoration: InputDecoration(
                  focusColor: Colors.blue,
                  hintText: 'Enter your notes here',
                  icon: Icon(Icons.note),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              maxLines: 8,
            )),
      ],
    );
  }

  Widget _menuItem(String name, IconData iconData, VoidCallback _onTap) {
    return InkWell(
      onTap: () {
        _onTap();
        _controller.hideMenu();
      },
      child: Row(
        children: <Widget>[
          Icon(
            iconData,
            size: 15,
            color: Colors.black,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reminderWidget() {
    return InkWell(
      onTap: () async {
        _selectedDayTime = await showTimePicker(
          builder: (context, timePicker) => Column(
            children: [
              timePicker ?? Container(),
              ElevatedButton(
                  onPressed: () {
                    _selectedDayTime = null;
                    Navigator.pop(context);
                  },
                  child: Text('No reminders'))
            ],
          ),
          context: context,
          initialTime: _selectedDayTime ?? TimeOfDay.now(),
        );
        setState(() {
          if (_selectedDayTime == null) {
            db.updateTask(widget.task.copyWith(reminderDate: null));
            appNotifications.cancelAllNotifications(widget.task.id);
          } else {
            setState(() {
              var temp = DateTime(kToday.year, kToday.month, kToday.day,
                  _selectedDayTime!.hour, _selectedDayTime!.minute);
              db.updateTask(widget.task.copyWith(reminderDate: temp)).then(
                  (value) => appNotifications.scheduleNotification(
                      widget.task.copyWith(reminderDate: temp)));
            });
          }
        });
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tileLeading(Icons.notifications_none, 'Reminder'),
              Card(
                elevation: 0,
                margin: EdgeInsets.all(8),
                color: AppColors.bleuGrey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _selectedDayTime == null
                        ? 'No Reminder'
                        : _selectedDayTime!.format(context),
                    style: TextStyle(color: AppColors.darkGrey),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  final CustomPopupMenuController _controller = CustomPopupMenuController();
  int lastitem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.trafficWhite,
      appBar: AppBar(
        centerTitle: true,
        title: widget.task.isChallenge
            ? Row(
                children: [
                  //b7e8ff00
                  Text('Challenge'),
                  SizedBox(
                    width: 8,
                  ),
                  LottieBuilder.asset(
                    'assets/small_prize.json',
                    height: 50,
                    width: 50,
                  ),
                ],
              )
            : Container(),
        elevation: 0,
        backgroundColor: AppColors.trafficWhite,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(20),
            child: CustomPopupMenu(
              menuBuilder: () => ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  color: AppColors.trafficWhite,
                  width: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          height: 80,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              _menuItem(
                                  isDone ? 'Mark as Undone' : 'Mark as Done',
                                  Icons.check, () {
                                setState(() {
                                  isDone = !isDone;
                                });
                                db.updateTask(
                                    widget.task.copyWith(isDone: isDone));
                              }),
                              _menuItem('Delete', Icons.delete, () {
                                !isDone && widget.task.isDone != isDone
                                    ? db.changePendingTasks(-1)
                                    : null;
                                db.deleteTask(widget.task);
                                Navigator.pop(context);
                              })
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              pressType: PressType.singleClick,
              verticalMargin: -10,
              controller: _controller,
              child: Icon(Icons.more_vert),
            ),
          )
        ],
      ),
      /*Container(
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        height: MediaQuery.of(context).size.height,*/
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //  _headerWidget(),
                Container(
                  padding: const EdgeInsets.all(0.0),
                  child: StreamBuilder(
                    stream: db.watchAllTodos(widget.task.id),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        lastitem = snapshot.data.length;
                        getNodesNeeded();
                        handleFocus();

                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return TodoTile(
                                  todo: snapshot.data[index],
                                  focusNode: _nodes[index],
                                  handleNextFocus: () {
                                    firstLoaded = false;
                                    db.insertTodo(TodosCompanion.insert(
                                        content: '', taskId: widget.task.id));
                                  },
                                  onPressed: () {
                                    Todo todo = snapshot.data[index];

                                    db.updateTodo(
                                        todo.copyWith(isDone: !todo.isDone));
                                  });
                            });
                      } else {
                        return Text('sad');
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      firstLoaded = false;
                      db.insertTodo(TodosCompanion.insert(
                          content: '', taskId: widget.task.id));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Add Sub-task',
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(color: AppColors.bleuGrey),
                _dueDateWidget(),
                Divider(color: AppColors.bleuGrey),
                _reminderWidget(),
                Divider(color: AppColors.bleuGrey),
                _noteWidget(),
              ],
            ),
          ),
        ),
        isDone
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              )
            : Container()
      ]),
      /*  floatingActionButton: FloatingActionButton(onPressed: () {
        db.insertTodo(
            TodosCompanion.insert(content: 'Eat Food', taskId: widget.task.id));
      }),*/
    );
  }

  void handleTasksStates() async {
    if (isDone && widget.task.isDone) {
      print('TRUE TRUE DO NOTHING');
    } else if (!isDone && !widget.task.isDone) {
      print('FALSE FALSE DO NOTHING');
    } else if (isDone && !widget.task.isDone) {
      print('first');
      await db.changeDoneTasks(1);
      await db.changePendingTasks(-1);
    } else if (!isDone && widget.task.isDone) {
      print('second');
      await db.changeDoneTasks(-1).then((value) => db.changePendingTasks(1));
    }
  }

  @override
  void dispose() {
    handleTasksStates();
    if (isDone && !widget.task.isDone && widget.task.isChallenge) {
      db.insertPastTask();
      db.updateTask(widget.task.copyWith(
          note: textEditingController.text,
          isDone: isDone,
          isChallenge: false));
      db.inscreaseScore(widget.task.score ?? 0);
    } else {
      db.updateTask(widget.task
          .copyWith(note: textEditingController.text, isDone: isDone));
    }
    _controller.dispose();

    _nodes.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }
}

import 'package:animate_icons/animate_icons.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tyme/UI/Components/TodoTile.dart';
import 'package:tyme/UI/pages/HomePage.dart';

import 'package:tyme/database/database.dart';
import 'package:tyme/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tyme/main.dart';
import 'package:tyme/providers/tasksProvider.dart';
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
  List<FocusNode> _nodes = [];
  late DateTime _selectedDateTime;
  TimeOfDay? _selectedDayTime;
  AnimateIconController controller = AnimateIconController();
  bool isPlaying = false;
  Categorie? _selectedCategory;
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
      for (int i = 0; i < lastitem; i++) _nodes.add(FocusNode());
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

  Widget _dateWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          child: Text(
            kToday.day.toString(),
            style: TextStyle(fontSize: 41, fontWeight: FontWeight.bold),
          ),
          height: 50,
          width: 50,
        ),
        SizedBox(
          width: 8,
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat('MMMM').format(kToday)),
              Text(kToday.year.toString())
            ],
          ),
          height: 50,
          width: 50,
        )
      ],
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
        db.updateTask(widget.task.copyWith(dueDate: _selectedDateTime));
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

  TextEditingController textEditingController = new TextEditingController();
  Widget _noteWidget() {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            height: 150,
            child: TextField(
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
              DateTime temp = DateTime(kToday.year, kToday.month, kToday.day,
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

  CustomPopupMenuController _controller = CustomPopupMenuController();
  int lastitem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.trafficWhite,
      appBar: AppBar(
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
              child: Icon(Icons.more_vert),
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
                                isDone = !isDone;
                                db.updateTask(
                                    widget.task.copyWith(isDone: isDone));
                              }),
                              _menuItem('Delete', Icons.delete, () {
                                db.deleteTask(widget.task);
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
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white.withOpacity(0.5),
        child: AbsorbPointer(
          absorbing: isDone,
          child: Padding(
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
                                    onPressed: () {
                                      Todo todo = snapshot.data[index];

                                      db.updateTodo(
                                          todo.copyWith(isDone: !todo.isDone));
                                    });
                              });
                        } else
                          return Text('sad');
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
                  _noteWidget()
                ],
              ),
            ),
          ),
        ),
      ),
      /*  floatingActionButton: FloatingActionButton(onPressed: () {
        db.insertTodo(
            TodosCompanion.insert(content: 'Eat Food', taskId: widget.task.id));
      }),*/
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    db.updateTask(widget.task.copyWith(note: textEditingController.text));
    _nodes.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:moor/moor.dart' as moor;
import 'package:tyme/UI/Components/AppTextField.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/main.dart';
import 'package:tyme/utils/dateUtils.dart';
import 'package:tyme/utils/konstants.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final DateTime selectedDay;

  const AddTaskBottomSheet({Key? key, required this.selectedDay})
      : super(key: key);

  @override
  _AddTaskBottomSheetState createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController noteTextEditingController = TextEditingController();
  int _selectedColorIndex = 0;
  int _selectedCategoryIndex = 0;
  DateTime _selectedDateTime = DateTime.now();
  TimeOfDay _selectedTimeOfDay = TimeOfDay.now();
  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.selectedDay;
  }

  void _handleDoneButton() {
    final _taskDate = DateTime(
        _selectedDateTime.year,
        _selectedDateTime.month,
        _selectedDateTime.day,
        _selectedTimeOfDay.hour,
        _selectedTimeOfDay.minute);

    db
        .insertTask(
          TasksCompanion.insert(
              title: titleTextEditingController.text,
              category: categories[_selectedCategoryIndex].id,
              note: noteTextEditingController.text,
              dueDate: _taskDate,
              isChallenge: moor.Value(_isChallenge),
              score: moor.Value(
                  scores[_selectedScoreindex == -1 ? 0 : _selectedScoreindex]
                      .score)),
        )
        .then((value) =>
            db.getTask(value).then((task) => Navigator.of(context).pop(task)));
  }

  int _selectedScoreindex = -1;
  Widget scorePicker() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: 500,
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: scores.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedScoreindex = index;
                    });

                    // ignore: always_specify_types
                    Future.delayed(const Duration(milliseconds: 200), () {
                      // When task is over, close the dialog
                      Navigator.pop(
                        context,
                      );
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.all(8),
                      height: 50,
                      child: Row(
                        children: [
                          LottieBuilder.asset('assets/medals/$index.json'),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            scores[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          Text(
                            'Score: ' + scores[index].score.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ) /*ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        leading: LottieBuilder.asset('assets/medals/$index.json'),
                        title: Text(scores[index].title),
                        onTap: () {
                          setState(() {
                            _selectedScoreindex = index;
                          });

                          // ignore: always_specify_types
                          Future.delayed(const Duration(milliseconds: 200), () {
                            // When task is over, close the dialog
                            Navigator.pop(
                              context,
                            );
                          });
                        },
                      ),*/
                      ),
                );
              },
            )),
      ),
    );
  }

/*https://lottiefiles.com/dsg_doe*/
  Widget categoryPicker() {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: 500,
            height: (categories.length * 50).toDouble(),
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 50,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      leading: Icon(
                        IconData(categories[index].iconData,
                            fontFamily: 'MaterialIcons'),
                        color: index == _selectedCategoryIndex
                            ? Colors.amber
                            : Colors.black,
                      ),
                      title: Text(categories[index].content),
                      onTap: () {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });

                        // ignore: always_specify_types
                        Future.delayed(const Duration(milliseconds: 200), () {
                          // When task is over, close the dialog
                          Navigator.pop(
                            context,
                          );
                        });
                      },
                    ));
              },
            )),
      ),
    );
  }

  Widget colorPicker() {
    return AlertDialog(
      content: Container(
          width: 500,
          height: (colorsList.length * 50).toDouble(),
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: colorsList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 50,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    leading: Icon(
                        index == _selectedColorIndex
                            ? Icons.lens
                            : Icons.trip_origin,
                        color: colorsList[index]),
                    title: Text(colorsNames[index]),
                    onTap: () {
                      setState(() {
                        _selectedColorIndex = index;
                      });

                      // ignore: always_specify_types
                      Future.delayed(const Duration(milliseconds: 200), () {
                        // When task is over, close the dialog
                        Navigator.pop(context);
                      });
                    },
                  ));
            },
          )),
    );
  }

  Widget _isChallengeWidget() {
    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        border:
            Border.all(color: Color(categories[_selectedCategoryIndex].color)),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Checkbox(
            activeColor: Color(categories[_selectedCategoryIndex].color),
            onChanged: (value) {
              value!
                  ? showDialog<Widget>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return scorePicker();
                      },
                    ).then((x) => setState(() => _isChallenge = value))
                  : setState(() => _isChallenge = value);
            },
            value: _isChallenge,
          ),
          SizedBox(
            width: 0,
          ),
          Text(_selectedScoreindex == -1
              ? 'Challenge !'
              : scores[_selectedScoreindex].title)
        ],
      ),
    );
  }

  bool _isChallenge = false;
  Widget _categoryWidget() {
    return GestureDetector(
      onTap: () {
        showDialog<Widget>(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return categoryPicker();
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Color(categories[_selectedCategoryIndex].color)),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                IconData(categories[_selectedCategoryIndex].iconData,
                    fontFamily: 'MaterialIcons'),
                color: Color(categories[_selectedCategoryIndex].color),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                categories[_selectedCategoryIndex].content,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - 30,
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              AppTextField(
                hintText: 'What Task',
                textEditingController: titleTextEditingController,
                isObligatory: true,
                color: Color(categories[_selectedCategoryIndex].color),
              ),
              AppTextField(
                  hintText: 'Description',
                  textEditingController: noteTextEditingController,
                  isObligatory: false,
                  color: Color(categories[_selectedCategoryIndex].color)),
              SizedBox(
                height: 8,
              ),
              ListTile(
                leading: GestureDetector(
                  onTap: () async {
                    final date = await showDatePicker(
                        context: context,
                        initialDate: widget.selectedDay,
                        firstDate: DateTime(kToday.year, 1, 1),
                        lastDate: DateTime(kToday.year, 31, 12));
                    setState(() {
                      _selectedDateTime = date ?? DateTime.now();
                    });
                  },
                  child: Text(
                      DateFormat.yMMMMd('fr_FR').format(widget.selectedDay)),
                ),
                trailing: GestureDetector(
                  onTap: () async {
                    final date = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {
                      _selectedTimeOfDay = date ?? TimeOfDay.now();
                    });
                  },
                  child: Text(_selectedTimeOfDay.format(context)),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                // width: MediaQuery.of(context).size.width,
                //height: 100,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: _categoryWidget(),
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.amber,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(child: _isChallengeWidget()),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) =>
                              Color(categories[_selectedCategoryIndex].color))),
                  onPressed: _handleDoneButton,
                  icon: Icon(Icons.done),
                  label: Text('Done'))
            ],
          ),
        )),
      ),
    );
  }
}

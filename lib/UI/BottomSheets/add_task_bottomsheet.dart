import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  TextEditingController titleTextEditingController =
      new TextEditingController();
  TextEditingController noteTextEditingController = new TextEditingController();
  int _selectedColorIndex = 0;
  int _selectedCategoryIndex = 0;
  DateTime _selectedDateTime = DateTime.now();
  TimeOfDay _selectedTimeOfDay = TimeOfDay.now();
  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.selectedDay;
  }

  Widget categoryPicker() {
    return AlertDialog(
      content: Container(
          width: 500,
          height: (categories.length * 50).toDouble(),
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 50,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
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
              ),
              AppTextField(
                hintText: 'Description',
                textEditingController: noteTextEditingController,
                isObligatory: false,
              ),
              SizedBox(
                height: 8,
              ),
              ListTile(
                leading: GestureDetector(
                  child: Text(
                      DateFormat.yMMMMd('fr_FR').format(widget.selectedDay)),
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
                ),
                trailing: GestureDetector(
                  child: Text(_selectedTimeOfDay.format(context)),
                  onTap: () async {
                    final date = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {
                      _selectedTimeOfDay = date ?? TimeOfDay.now();
                    });
                  },
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                leading: Icon(
                  IconData(categories[_selectedCategoryIndex].iconData,
                      fontFamily: 'MaterialIcons'),
                  color: Color(categories[_selectedCategoryIndex].color),
                ),
                title: Text(categories[_selectedCategoryIndex].content),
                onTap: () {
                  showDialog<Widget>(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return categoryPicker();
                    },
                  );
                },
              ),
              SizedBox(
                height: 8,
              ),
              /*  ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                leading: Icon(
                  Icons.lens,
                  color: colorsList[_selectedColorIndex],
                ),
                title: Text(colorsNames[_selectedColorIndex]),
                onTap: () {
                  showDialog<Widget>(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return colorPicker();
                    },
                  );
                },
              ),*/
              ElevatedButton.icon(
                  onPressed: () {
                    final DateTime _taskDate = DateTime(
                        _selectedDateTime.year,
                        _selectedDateTime.month,
                        _selectedDateTime.day,
                        _selectedTimeOfDay.hour,
                        _selectedTimeOfDay.minute);

                    db
                        .insertTask(TasksCompanion.insert(
                            title: titleTextEditingController.text,
                            category: _selectedCategoryIndex,
                            note: noteTextEditingController.text,
                            dueDate: _taskDate))
                        .then((value) => db
                            .getTask(value)
                            .then((task) => Navigator.of(context).pop(task)));

                    /* Navigator.of(context).pop(Task(
                      id: 0,
                        color: colorsList[_selectedColorIndex],
                        dueDate: _taskDate,
                        //  dateEnd: widget.selectedDay ?? DateTime.now(),
                        isAllDay: false,
                        category: categories[_selectedCategoryIndex],
                        title: titleTextEditingController.text,
                        note: noteTextEditingController.text));*/
                  },
                  icon: Icon(Icons.done),
                  label: Text('Done'))
            ],
          ),
        )),
      ),
    );
  }
}

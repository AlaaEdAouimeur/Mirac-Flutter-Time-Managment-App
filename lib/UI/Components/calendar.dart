import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moor/moor.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tyme/UI/BottomSheets/add_task_bottomsheet.dart';
import 'package:tyme/UI/Components/TaskTile.dart';
import 'package:tyme/UI/pages/TaskDetails.dart';

import 'package:tyme/database/database.dart';
import 'package:tyme/main.dart';
import 'package:tyme/providers/tasksProvider.dart';

import 'package:tyme/utils/dateUtils.dart';
import 'package:tyme/utils/konstants.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _lastDay = kLastDay;
  DateTime _firstDay = kFirstDay;
  List<Task> tasks = [];

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = kToday;
  DateTime _selectedDay = kToday;

  /*List<Task> _getTasksForDay(DateTime day, context) {
    context.read(appTasksProvider).getTasksWhere(day);
    return context.read(appTasksProvider).state;
  }*/

  void _dateSelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      _selectedDay = selectedDate;
      _focusedDay = focusedDate;
    });
  }

  void _showBottomSheet(BuildContext context) async {
    Task task = await showModalBottomSheet<Task>(
            isScrollControlled: true,
            isDismissible: false,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            ),
            context: context,
            builder: (context) {
              return AddTaskBottomSheet(
                selectedDay: _selectedDay,
              );
            }) ??
        Task(
            id: 0,
            title: 'title',
            category: 1,
            note: 'note',
            isDone: false,
            dueDate: DateTime.now(),
            reminderDate: DateTime.now());
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TaskDetails(task: task)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, child) {
          return StreamBuilder<List<Task>>(
              stream: db.watchAllTasks(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Task> _dayTasks = snapshot.data!
                      .where((element) =>
                          element.dueDate.day == _selectedDay.day &&
                          element.dueDate.month == _selectedDay.month &&
                          element.dueDate.year == _selectedDay.year)
                      .toList();
                  List<Task> _tasks = snapshot.data ?? [];
                  return ListView(
                    primary: true,
                    children: [
                      Stack(
                        children: [
                          Container(
                              height: 400,
                              child: Opacity(
                                child: Image.asset(
                                  'assets/bg.jpg',
                                  fit: BoxFit.fitHeight,
                                ),
                                opacity: 0.5,
                              )),
                          Opacity(
                            opacity: 1,
                            child: TableCalendar(
                              locale: 'fr_FR',
                              calendarFormat: calendarFormat,
                              calendarBuilders: CalendarBuilders(),
                              availableGestures:
                                  AvailableGestures.horizontalSwipe,
                              dayHitTestBehavior: HitTestBehavior.deferToChild,
                              firstDay: _firstDay,
                              focusedDay: _focusedDay,
                              lastDay: _lastDay,
                              availableCalendarFormats: {
                                CalendarFormat.week: 'Week',
                                CalendarFormat.month: 'Month',
                              },
                              onDaySelected: _dateSelected,
                              eventLoader: (df) {
                                return _tasks
                                    .where((element) =>
                                        element.dueDate.day == df.day &&
                                        element.dueDate.month == df.month &&
                                        element.dueDate.year == df.year)
                                    .toList();
                              },
                              selectedDayPredicate: (day) {
                                return isSameDay(_selectedDay, day);
                              },
                              onFormatChanged: (newFormat) =>
                                  setState(() => calendarFormat = newFormat),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),

                      //  initialData: initialData ,
                      /* if (snapshot.connectionState == ConnectionState.waiting)
                        SpinKitChasingDots(
                          color: Colors.blue.shade900,
                        ),*/
                      if (snapshot.hasError) Text('Error Try again'),
                      if (snapshot.hasData)
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _dayTasks.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TaskTile(
                                  task: _dayTasks[index],
                                ),
                              );
                            })
                      else if (snapshot.data!.isEmpty)
                        Text('ADD A TASK')
                      else
                        Text('not'),

                      const SizedBox(height: 8.0),
                    ],
                  );
                } else
                  return Text('not');
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: AppColors.trafficWhite,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tyme/UI/BottomSheets/add_task_bottomsheet.dart';
import 'package:tyme/UI/Components/TaskTile.dart';

import 'package:tyme/models/Task.dart';
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
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = kToday;
  DateTime _selectedDay = kToday;
  List<Task> tasks = [];

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
    final Task? task = await showModalBottomSheet<Task>(
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
        });

    context.read(appTasksProvider.notifier).addTask(task ??
        Task(
            color: Colors.yellow,
            dueDate: DateTime.now(),
            category: categories[0],
            isAllDay: false,
            note: 'dsd',
            title: 'dsd'));
    // tasks.add(task ?? tasks[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final tasksProvider = watch(appTasksProvider.notifier);
        final tasks = watch(appTasksProvider);
        return ListView(
          primary: true,
          children: [
            TableCalendar(
              locale: 'fr_FR',
              calendarFormat: calendarFormat,
              calendarBuilders: CalendarBuilders(),
              availableGestures: AvailableGestures.horizontalSwipe,
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
                return tasksProvider.getTasksWhere(df);
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onFormatChanged: (newFormat) =>
                  setState(() => calendarFormat = newFormat),
            ),
            const SizedBox(height: 8.0),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: tasksProvider.getTasksWhere(_selectedDay).length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TaskTile(
                      task: tasksProvider.getTasksWhere(_selectedDay)[index],
                    ),
                  );
                }),
            const SizedBox(height: 8.0),
            ElevatedButton(
                onPressed: () => _showBottomSheet(context),
                child: Icon(Icons.add))
          ],
        );
      },
    );
  }
}

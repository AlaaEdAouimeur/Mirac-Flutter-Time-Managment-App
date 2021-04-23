import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tyme/models/Task.dart';
import 'package:tyme/utils/dateUtils.dart';

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
  late List<Task> tasks;
  @override
  void initState() {
    super.initState();
    tasks = _getTasks(kToday);
  }

  List<Task> _getTasksForDay(DateTime day) {
    // Implementation example
    return tasks.where((element) => element.dateStart.day == day.day).toList();
  }

  void _dateSelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      _selectedDay = selectedDate;
      _focusedDay = focusedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TableCalendar(
          calendarFormat: calendarFormat,
          dayHitTestBehavior: HitTestBehavior.deferToChild,
          firstDay: _firstDay,
          focusedDay: _focusedDay,
          lastDay: _lastDay,
          availableCalendarFormats: {
            CalendarFormat.week: 'Week',
            CalendarFormat.month: 'Month',
          },
          onDaySelected: _dateSelected,
          eventLoader: _getTasksForDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onFormatChanged: (newFormat) =>
              setState(() => calendarFormat = newFormat),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                tasks.add(Task(
                    color: Colors.red,
                    dateStart: _selectedDay,
                    dateEnd: _selectedDay,
                    iconData: Icons.history_edu,
                    isAllDay: false,
                    note: 'dsd',
                    title: 'dsd'));
              });
            },
            child: Icon(Icons.add))
      ],
    );
  }

  List<Task> _getTasks(DateTime dt) {
    final List<Color> colorCollection = <Color>[];
    colorCollection.add(const Color(0xFF0F8644));
    colorCollection.add(const Color(0xFF8B1FA9));
    colorCollection.add(const Color(0xFFD20100));
    colorCollection.add(const Color(0xFFFC571D));
    colorCollection.add(const Color(0xFF3D4FB5));
    colorCollection.add(const Color(0xFFE47C73));
    colorCollection.add(const Color(0xFF636363));
    colorCollection.add(const Color(0xFF0A8043));
    colorCollection.add(const Color(0xFF36B37B));
    colorCollection.add(const Color(0xFF01A1EF));
    colorCollection.add(const Color(0xFF3D4FB5));
    colorCollection.add(const Color(0xFFE47C73));
    colorCollection.add(const Color(0xFF636363));
    colorCollection.add(const Color(0xFF0A8043));
    final List<Task> tasks = <Task>[];
    for (int i = 0; i <= 2; i++) {
      tasks.add(Task(
          title: 'Task ' + i.toString(),
          note: 'Note ' + i.toString(),
          color: colorCollection[i],
          iconData: Icons.work,
          dateStart: DateTime.now(),
          dateEnd: DateTime.now().add(Duration(hours: i)),
          isAllDay: false));
    }
    return tasks;
  }
}

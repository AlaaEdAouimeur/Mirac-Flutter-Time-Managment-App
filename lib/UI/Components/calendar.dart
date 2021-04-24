import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tyme/UI/BottomSheets/add_task_bottomsheet.dart';
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
    return tasks
        .where((element) => element.dateStart.compareTo(day) == 0)
        .toList();
  }

  void _dateSelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      _selectedDay = selectedDate;
      _focusedDay = focusedDate;
    });
  }

  void _showBottomSheet(BuildContext context) async {
    final Task? task = await showModalBottomSheet<Task>(
        isScrollControlled: true,
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
    setState(() {
      tasks.add(task ?? tasks[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: true,
      children: [
        TableCalendar(
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
          eventLoader: _getTasksForDay,
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
            itemCount: _getTasksForDay(_selectedDay).length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  onTap: () => print('${tasks[index]}'),
                  title: Text('${_getTasksForDay(_selectedDay)[index].title}'),
                ),
              );
            }),
        const SizedBox(height: 8.0),
        ElevatedButton(
            onPressed: () => _showBottomSheet(context), child: Icon(Icons.add))
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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tyme/UI/Components/calendar.dart';
import 'package:tyme/calendarDataSource.dart';
import 'package:tyme/models/Task.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TasksDataSource _events;
  @override
  void initState() {
    super.initState();
    _events = TasksDataSource(source: _getTasks(DateTime.now()));
  }

  CalendarFormat cf = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Hello, Alaa!',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      //drawer: Drawer(child:,),
      //
      body: CalendarWidget(),
      /* ListView(
        children: [
          Container(
            height: 600,
            child: SfCalendar(
              onTap: (calendarTapDetails) {
              
                print(calendarTapDetails.resource?.displayName);

             
              },
              view: CalendarView.month,
              dataSource: _events,
              monthViewSettings:
                  MonthViewSettings(showAgenda: true, numberOfWeeksInView: 6),
              timeSlotViewSettings: TimeSlotViewSettings(
                  minimumAppointmentDuration: const Duration(minutes: 600000)),
            ),
          )
        ],
      ),*/
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

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:tyme/UI/Components/calendar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
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
}

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
      body: CalendarWidget(),
    );
  }
}

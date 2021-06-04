import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:tyme/UI/Components/calendar.dart';
import 'package:tyme/UI/pages/TasksHomePage.dart';
import 'package:tyme/UI/pages/UserHome.dart';
import 'package:tyme/main.dart';
import 'package:tyme/utils/konstants.dart';
import 'package:tyme/utils/local_notifications.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  int _index = 0;
  CalendarFormat cf = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.indicator,
        elevation: 0,
        backgroundColor: Colors.white,
        snakeViewColor: AppColors.trafficWhite,
        selectedItemColor: Colors.black,
        unselectedItemColor: AppColors.darkGrey.withOpacity(0.6),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _index,
        onTap: (i) {
          setState(() {
            _index = i;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded), label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_rounded), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: [TasksHomePage(), CalendarWidget(), UserHome()],
      ),
    );
  }
}

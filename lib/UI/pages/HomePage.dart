import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:tyme/UI/Components/calendar.dart';
import 'package:tyme/UI/pages/TasksHomePage.dart';
import 'package:tyme/main.dart';
import 'package:tyme/utils/konstants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('tom');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    super.initState();
  }

  Future _showNotification() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Notification',
      'Flutter is awesome',
      platformChannelSpecifics,
      payload: 'This is notification detail Text...',
    );
  }

  Future onSelectNotification(String? payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("Your Notification Detail"),
          content: Text("Payload : $payload"),
        );
      },
    );
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
          _showNotification();
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
        children: [
          TasksHomePage(),
          CalendarWidget(),
          Container(
            color: Colors.red,
            height: 500,
            width: 500,
          )
        ],
      ),
    );
  }
}

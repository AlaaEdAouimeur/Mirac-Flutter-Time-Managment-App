import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:tyme/UI/pages/TaskDetails.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/utils/global_vars.dart';

class AppNotifications {
  late var zone;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'tyme', 'tyme', 'best time managment app',
      importance: Importance.max, priority: Priority.high);
  Future<void> setup() async {}

  void initPlugin() async {
    tz.initializeTimeZones();
    zone = tz.getLocation('Africa/Algiers');
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('tom');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future showNotification() async {
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
  }

  Future scheduleNotification(Task task) async {
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.zonedSchedule(
        task.id,
        'Task to be done',
        'Task ' + task.title + ' has some todos to be DONE',
        tz.TZDateTime.from(task.reminderDate ?? DateTime.now(), zone),
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        payload: task.toJsonString(),
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future onSelectNotification(String? payload) async {
    final Task _task = Task.fromJson(jsonDecode(payload ?? ''));
    Navigator.of(GlobalVariable.navState.currentContext!).push(MaterialPageRoute(builder: (context) => TaskDetails(task: _task)));
  }
}

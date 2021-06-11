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
      FlutterLocalNotificationsPlugin();
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'tyme', 'tyme', 'best time managment app',
      importance: Importance.max, priority: Priority.high);
  Future<void> setup() async {}

  void initPlugin() async {
    tz.initializeTimeZones();
    zone = tz.getLocation('Africa/Algiers');
    var initializationSettingsAndroid = AndroidInitializationSettings('tom');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future showNotification() async {
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    // ignore: unused_local_variable
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
  }

  Future scheduleNotification(Task task) async {
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
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
    final _task = Task.fromJson(jsonDecode(payload ?? ''));
    await Navigator.of(GlobalVariable.navState.currentContext!).push(
        MaterialPageRoute(builder: (context) => TaskDetails(task: _task)));
  }
}

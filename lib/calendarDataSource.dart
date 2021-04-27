import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tyme/models/Category.dart';

import 'package:tyme/models/Task.dart';

class TasksDataSource extends CalendarDataSource {
  List<Task> source;
  TasksDataSource({
    required this.source,
  });

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].dateStart;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].dateEnd;
  }

  @override
  bool isAllDay(int index) {
    return source[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return source[index].title;
  }

  @override
  Color getColor(int index) {
    return source[index].color;
  }

  Category getCategory(int index) {
    return source[index].category;
  }
}

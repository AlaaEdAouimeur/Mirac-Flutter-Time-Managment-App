import 'package:flutter/material.dart';
import 'package:tyme/models/Task.dart';
import 'package:tyme/utils/konstants.dart';

class TaskResources {
  static List<Task> getTasks() {
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
          category: categories[0],
          dateStart: DateTime.now(),
          dateEnd: DateTime.now().add(Duration(hours: i)),
          isAllDay: false));
    }
    return tasks;
  }
}

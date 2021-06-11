import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tyme/database/database.dart';

class TasksProvider extends StateNotifier<List<Task>> {
  TasksProvider(List<Task> state) : super(state);
  final List<Task> _allTasks = [];

  List<Task> get getTasks => state = _allTasks;
  List<Task> getTasksWhere(DateTime dateTime) {
    return _allTasks
        .where((element) =>
            dateTime.day == element.dueDate.day &&
            dateTime.month == element.dueDate.month &&
            dateTime.year == element.dueDate.year)
        .toList();
  }

  void addTask(Task task) {
    _allTasks.add(task);
    getTasks;
  }

  void deleteTask(Task task) {
    _allTasks.removeWhere((element) => element == task);
    getTasks;
  }

  void updateTask(Task task) {
    _allTasks.singleWhere((element) => task == element).copyWith(
          category: task.category,

          title: task.title,
          dueDate: task.dueDate,
          //TODO FUNCTIONS CRUD
          note: task.note,
        );
    getTasks;
  }
}

final appTasksProvider = StateNotifierProvider<TasksProvider, List<Task>>(
    (ref) => TasksProvider([]));

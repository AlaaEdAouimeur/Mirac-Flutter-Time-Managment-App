import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tyme/models/Task.dart';
import 'package:tyme/models/Todo.dart';
import 'package:tyme/providers/tasksProvider.dart';

class TodosProvider extends StateNotifier<List<Todo>> {
  final Task task;
  TodosProvider(List<Todo> state, this.task) : super(state);
}

final filterProvider = StateProvider((ref) {
  final task = ref.read(appTasksProvider.notifier);
});
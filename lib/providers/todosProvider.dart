import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tyme/database/database.dart';

class TodosProvider extends StateNotifier<List<Todo>> {
  final Task task;
  TodosProvider(List<Todo> state, this.task) : super(state);
}

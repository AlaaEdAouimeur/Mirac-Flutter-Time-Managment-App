import 'dart:convert';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';

import 'package:tyme/models/Category.dart';
import 'package:tyme/models/Todo.dart';

class Task {
  String title;
  String note;
  Color color;
  Category category;
  DateTime dueDate;
  bool isAllDay;
  List<Todo> todos;
  Task({
    required this.title,
    required this.note,
    required this.color,
    required this.category,
    required this.dueDate,
    required this.isAllDay,
    this.todos = const [],
  });

  Task copyWith({
    String? title,
    String? note,
    Color? color,
    Category? category,
    DateTime? dueDate,
    bool? isAllDay,
    List<Todo>? todos,
  }) {
    return Task(
      title: title ?? this.title,
      note: note ?? this.note,
      color: color ?? this.color,
      category: category ?? this.category,
      dueDate: this.dueDate,
      isAllDay: isAllDay ?? this.isAllDay,
      todos: todos ?? this.todos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'note': note,
      'color': color.value,
      'category': category.toMap(),
      'dueDate': dueDate.millisecondsSinceEpoch,
      'isAllDay': isAllDay,
      'todos': todos.map((x) => x.toMap()).toList(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      note: map['note'],
      color: Color(map['color']),
      category: Category.fromMap(map['category']),
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
      isAllDay: map['isAllDay'],
      todos: List<Todo>.from(map['todos']?.map((x) => Todo.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());
  int get todosCount => todos.length;
  int get doneTodosCount =>
      todos.where((element) => element.isDone == true).length;
  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task(title: $title, note: $note, color: $color, category: $category, dateStart: $dueDate, isAllDay: $isAllDay, todos: $todos)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task &&
        other.title == title &&
        other.note == note &&
        other.color == color &&
        other.category == category &&
        other.dueDate == dueDate &&
        other.isAllDay == isAllDay &&
        listEquals(other.todos, todos);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        note.hashCode ^
        color.hashCode ^
        category.hashCode ^
        dueDate.hashCode ^
        isAllDay.hashCode ^
        todos.hashCode;
  }
}

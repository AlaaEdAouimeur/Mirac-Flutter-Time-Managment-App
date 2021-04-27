import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:tyme/models/Category.dart';

class Task {
  String title;
  String note;
  Color color;
  Category category;
  DateTime dateStart;
  DateTime dateEnd;
  bool isAllDay;
  Task({
    required this.title,
    required this.note,
    required this.color,
    required this.category,
    required this.dateStart,
    required this.dateEnd,
    required this.isAllDay,
  });

  Task copyWith({
    String? title,
    String? note,
    Color? color,
    Category? category,
    DateTime? dateStart,
    DateTime? dateEnd,
    bool? isAllDay,
  }) {
    return Task(
      title: title ?? this.title,
      note: note ?? this.note,
      color: color ?? this.color,
      category: category ?? this.category,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      isAllDay: isAllDay ?? this.isAllDay,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'note': note,
      'color': color.value,
      'category': category.toMap(),
      'dateStart': dateStart.millisecondsSinceEpoch,
      'dateEnd': dateEnd.millisecondsSinceEpoch,
      'isAllDay': isAllDay,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      note: map['note'],
      color: Color(map['color']),
      category: Category.fromMap(map['category']),
      dateStart: DateTime.fromMillisecondsSinceEpoch(map['dateStart']),
      dateEnd: DateTime.fromMillisecondsSinceEpoch(map['dateEnd']),
      isAllDay: map['isAllDay'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task(title: $title, note: $note, color: $color, category: $category, dateStart: $dateStart, dateEnd: $dateEnd, isAllDay: $isAllDay)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task &&
        other.title == title &&
        other.note == note &&
        other.color == color &&
        other.category == category &&
        other.dateStart == dateStart &&
        other.dateEnd == dateEnd &&
        other.isAllDay == isAllDay;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        note.hashCode ^
        color.hashCode ^
        category.hashCode ^
        dateStart.hashCode ^
        dateEnd.hashCode ^
        isAllDay.hashCode;
  }
}

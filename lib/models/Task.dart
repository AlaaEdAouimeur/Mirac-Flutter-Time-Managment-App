import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Task {
  String title;
  String note;
  Color color;
  IconData iconData;
  DateTime dateStart;
  DateTime dateEnd;
  bool isAllDay;
  Task({
    required this.title,
    required this.note,
    required this.color,
    required this.iconData,
    required this.dateStart,
    required this.dateEnd,
    required this.isAllDay,
  });

  Task copyWith({
    String? title,
    String? note,
    Color? color,
    IconData? iconData,
    DateTime? dateStart,
    DateTime? dateEnd,
    bool? isAllDay,
  }) {
    return Task(
      title: title ?? this.title,
      note: note ?? this.note,
      color: color ?? this.color,
      iconData: iconData ?? this.iconData,
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
      'iconData': iconData.codePoint,
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
      iconData: IconData(map['iconData'], fontFamily: 'MaterialIcons'),
      dateStart: DateTime.fromMillisecondsSinceEpoch(map['dateStart']),
      dateEnd: DateTime.fromMillisecondsSinceEpoch(map['dateEnd']),
      isAllDay: map['isAllDay'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task(title: $title, note: $note, color: $color, iconData: $iconData, dateStart: $dateStart, dateEnd: $dateEnd, isAllDay: $isAllDay)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task &&
        other.title == title &&
        other.note == note &&
        other.color == color &&
        other.iconData == iconData &&
        other.dateStart == dateStart &&
        other.dateEnd == dateEnd &&
        other.isAllDay == isAllDay;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        note.hashCode ^
        color.hashCode ^
        iconData.hashCode ^
        dateStart.hashCode ^
        dateEnd.hashCode ^
        isAllDay.hashCode;
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/models/Task.dart';

class Challenge {
  List<Task> tasks;
  int score;
  DateTime dateNow;
  DateTime dateBefore;
  Challenge({
    required this.tasks,
    required this.score,
    required this.dateNow,
    required this.dateBefore,
  });

  Challenge copyWith({
    List<Task>? tasks,
    int? score,
    DateTime? dateNow,
    DateTime? dateBefore,
  }) {
    return Challenge(
      tasks: tasks ?? this.tasks,
      score: score ?? this.score,
      dateNow: dateNow ?? this.dateNow,
      dateBefore: dateBefore ?? this.dateBefore,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tasks': tasks.map((x) => x.toMap()).toList(),
      'score': score,
      'dateNow': dateNow.millisecondsSinceEpoch,
      'dateBefore': dateBefore.millisecondsSinceEpoch,
    };
  }

  factory Challenge.fromMap(Map<String, dynamic> map) {
    return Challenge(
      tasks: List<Task>.from(map['tasks']?.map((x) => Task.fromMap(x))),
      score: map['score'],
      dateNow: DateTime.fromMillisecondsSinceEpoch(map['dateNow']),
      dateBefore: DateTime.fromMillisecondsSinceEpoch(map['dateBefore']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Challenge.fromJson(String source) =>
      Challenge.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Challenge(tasks: $tasks, score: $score, dateNow: $dateNow, dateBefore: $dateBefore)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Challenge &&
        listEquals(other.tasks, tasks) &&
        other.score == score &&
        other.dateNow == dateNow &&
        other.dateBefore == dateBefore;
  }

  @override
  int get hashCode {
    return tasks.hashCode ^
        score.hashCode ^
        dateNow.hashCode ^
        dateBefore.hashCode;
  }
}

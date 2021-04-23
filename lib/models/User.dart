import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:tyme/models/Quote.dart';

class User {
  String name;
  String lastName;
  int score;
  List<Quote> quotes;
  User({
    required this.name,
    required this.lastName,
    required this.score,
    required this.quotes,
  });

  User copyWith({
    String? name,
    String? lastName,
    int? score,
    List<Quote>? quotes,
  }) {
    return User(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      score: score ?? this.score,
      quotes: quotes ?? this.quotes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastName': lastName,
      'score': score,
      'quotes': quotes.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      lastName: map['lastName'],
      score: map['score'],
      quotes: List<Quote>.from(map['quotes']?.map((x) => Quote.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, lastName: $lastName, score: $score, quotes: $quotes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.name == name &&
        other.lastName == lastName &&
        other.score == score &&
        listEquals(other.quotes, quotes);
  }

  @override
  int get hashCode {
    return name.hashCode ^ lastName.hashCode ^ score.hashCode ^ quotes.hashCode;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';

class Category {
  String name;
  IconData iconData;
  Category({
    required this.name,
    required this.iconData,
  });

  Category copyWith({
    String? name,
    IconData? iconData,
  }) {
    return Category(
      name: name ?? this.name,
      iconData: iconData ?? this.iconData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'iconData': iconData.codePoint,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      iconData: IconData(map['iconData'], fontFamily: 'MaterialIcons'),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() => 'Category(name: $name, iconData: $iconData)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.name == name &&
        other.iconData == iconData;
  }

  @override
  int get hashCode => name.hashCode ^ iconData.hashCode;
}

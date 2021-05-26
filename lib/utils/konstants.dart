import 'package:flutter/material.dart';
import 'package:tyme/database/database.dart';

const List<Color> colorsList = [
  Colors.red,
  Colors.amber,
  Colors.green,
  Colors.grey,
  Colors.yellow,
  Colors.blue,
];
const List<String> colorsNames = [
  'red',
  'amber',
  'green',
  'grey',
  'yellow',
  'blue'
];

class AppColors {
  static Color bleuGrey = Colors.blueGrey[100] ?? Color(0xff);
  static Color trafficWhite = Color(0xffedf6ff);
  static Color darkGrey = Color(0xff7a7e81);
}

List<Categorie> categories = [
  Categorie(
    color: Colors.red.value,
    id: 0,
    content: 'Work',
    iconData: Icons.work.codePoint,
  ),
  Categorie(
      color: Colors.amber.value,
      id: 0,
      content: 'Famille',
      iconData: Icons.family_restroom.codePoint),
  Categorie(
      color: Colors.green.value,
      id: 0,
      content: 'House',
      iconData: Icons.house.codePoint),
  Categorie(
      color: Colors.orange.value,
      id: 0,
      content: 'Divertisement',
      iconData: Icons.local_play.codePoint),
  Categorie(
      color: Colors.grey.value,
      id: 0,
      content: 'Studies',
      iconData: Icons.book.codePoint),
];

import 'package:flutter/material.dart';

import 'package:tyme/database/database.dart';

List<ItemModel> items = [
  ItemModel(title: 'Mark as done', icondata: Icons.check),
  ItemModel(title: 'Mark as done', icondata: Icons.check),
];
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
  static Color bleuGrey = Colors.blueGrey[100] ?? Color(0x000000ff);
  static Color trafficWhite = Color(0xffedf6ff);
  static Color darkGrey = Color(0xff7a7e81);
}

List<Score> scores = [
  Score(title: 'Gold', score: 500),
  Score(title: 'Silver', score: 300),
  Score(title: 'Bronze', score: 100),
];
List<Categorie> categories = [
  Categorie(
    color: Colors.red.value,
    id: 0,
    content: 'Work',
    iconData: Icons.work.codePoint,
  ),
  Categorie(
      color: Colors.amber.value,
      id: 1,
      content: 'Famille',
      iconData: Icons.family_restroom.codePoint),
  Categorie(
      color: Colors.green.value,
      id: 2,
      content: 'House',
      iconData: Icons.house.codePoint),
  Categorie(
      color: Colors.orange.value,
      id: 3,
      content: 'Divertisement',
      iconData: Icons.local_play.codePoint),
  Categorie(
      color: Colors.grey.value,
      id: 4,
      content: 'Studies',
      iconData: Icons.book.codePoint),
  Categorie(
      color: Colors.greenAccent.value,
      id: 5,
      content: 'Other',
      iconData: Icons.bookmark_outline_sharp.codePoint),
];

class ItemModel {
  String title;
  IconData icondata;
  ItemModel({
    required this.title,
    required this.icondata,
  });
}

class Score {
  String title;
  int score;
  Score({
    required this.title,
    required this.score,
  });
}

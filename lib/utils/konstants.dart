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

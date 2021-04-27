import 'package:flutter/material.dart';
import 'package:tyme/models/Category.dart';

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
List<Category> categories = [
  Category(name: 'Work', iconData: Icons.work),
  Category(name: 'Famille', iconData: Icons.family_restroom),
  Category(name: 'House', iconData: Icons.house),
  Category(name: 'Divertisement', iconData: Icons.local_play_outlined),
  Category(name: 'Studies', iconData: Icons.book),
];

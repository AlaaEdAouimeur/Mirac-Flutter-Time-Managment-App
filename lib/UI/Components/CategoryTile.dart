import 'package:flutter/material.dart';

import 'package:tyme/database/database.dart';

class CategoryTile extends StatelessWidget {
  final Categorie? category;

  const CategoryTile({Key? key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: Icon(IconData(category?.iconData ?? 0xff)),
      title: Text(category?.content ?? ''),
    );
  }
}

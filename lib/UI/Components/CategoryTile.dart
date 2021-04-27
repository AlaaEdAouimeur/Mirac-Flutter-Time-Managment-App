import 'package:flutter/material.dart';

import 'package:tyme/models/Category.dart';

class CategoryTile extends StatelessWidget {
  final Category? category;

  const CategoryTile({Key? key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: Icon(category?.iconData),
      title: Text(category?.name ?? ''),
    );
  }
}

import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;

  const AppTextField({Key? key, this.hintText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                borderSide: BorderSide(width: 1.5)),
            filled: true,
            fillColor: Colors.grey[200]),
        onChanged: (s) {},
        onTap: () {},
      ),
    );
  }
}

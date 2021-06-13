import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String hintText;
  final Color color;
  final TextEditingController textEditingController;
  final bool isObligatory;
  AppTextField(
      {Key? key,
      required this.hintText,
      required this.textEditingController,
      required this.isObligatory,
      required this.color})
      : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  Color borderColor = Colors.black;

  String? _validate(String? string) {
    if (widget.isObligatory) {
      if (string == null) {
        return 'this is a required field';
      } else {
        if (string.isEmpty || string.length < 3) {
          return 'enter over 3 characters';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextFormField(
        validator: _validate,
        controller: widget.textEditingController,
        decoration: InputDecoration(
            focusColor: widget.color,
            //  errorText: _validate(widget.textEditingController.text),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            hintText: widget.hintText,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                borderSide: BorderSide(width: 1.5)),
            filled: true,
            fillColor: Colors.grey[200]),
        onSaved: _validate,
        onFieldSubmitted: _validate,
        onChanged: _validate,
      ),
    );
  }
}

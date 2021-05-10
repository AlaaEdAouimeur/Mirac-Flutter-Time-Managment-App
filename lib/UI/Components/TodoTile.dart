import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tyme/models/Task.dart';
import 'package:tyme/models/Todo.dart';

class TodoTile extends StatefulWidget {
  final Todo todo;
  final VoidCallback onPressed;
  const TodoTile({Key? key, required this.todo, required this.onPressed})
      : super(key: key);
  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile>
    with SingleTickerProviderStateMixin {
  AnimateIconController controller = AnimateIconController();
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Buy the milk',
        style: TextStyle(
            color: widget.todo.isDone ? Colors.grey : Colors.black,
            decoration: widget.todo.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none),
      ),
      trailing: AnimateIcons(
        startIcon: Icons.lens_outlined,
        endIcon: Icons.check_circle_outline,
        startIconColor: Colors.grey,
        endIconColor: Colors.green,
        controller: controller,
        duration: Duration(milliseconds: 200),
        onStartIconPress: () {
          setState(() {
            widget.onPressed();
          });
          return true;
        },
        onEndIconPress: () {
          setState(() {
            widget.onPressed();
          });
          return true;
        },
      ),
      onTap: () {},
    );
  }
}

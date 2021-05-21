import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/database/database.dart';

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
  bool isDone = false;
  @override
  void initState() {
    isDone = widget.todo.isDone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.todo.content,
        style: TextStyle(
            color: widget.todo.isDone ? Colors.grey : Colors.black,
            decoration: widget.todo.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none),
      ),
      trailing: AnimateIcons(
        startIcon: isDone ? Icons.check_circle_outline : Icons.lens_outlined,
        endIcon: isDone ? Icons.lens_outlined : Icons.check_circle_outline,
        startIconColor: isDone ? Colors.green : Colors.grey,
        endIconColor: isDone ? Colors.grey : Colors.green,
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

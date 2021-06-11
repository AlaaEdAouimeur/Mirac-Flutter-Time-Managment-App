import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/main.dart';
import 'package:tyme/utils/konstants.dart';

class TodoTile extends StatefulWidget {
  final Todo todo;
  final VoidCallback onPressed;
  final VoidCallback handleNextFocus;
  final FocusNode focusNode;
  const TodoTile(
      {Key? key,
      required this.todo,
      required this.focusNode,
      required this.onPressed,
      required this.handleNextFocus})
      : super(key: key);
  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile>
    with SingleTickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();
  AnimateIconController controller = AnimateIconController();
  bool isPlaying = false;
  bool isDone = false;
  @override
  void initState() {
    textEditingController.text = widget.todo.content;
    isDone = widget.todo.isDone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
          height: 38,
          // color: Colors.red,
          child: TextField(
            focusNode: widget.focusNode,
            style: TextStyle(
                color: widget.todo.isDone ? Colors.grey : Colors.black,
                decoration: widget.todo.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
            onEditingComplete: () {
              widget.handleNextFocus();
              widget.todo.copyWith(content: textEditingController.text);
            },
            onSubmitted: (sd) {
              widget.focusNode.unfocus();
              db.updateTodo(
                  widget.todo.copyWith(content: textEditingController.text));
            },
            controller: textEditingController,
            decoration: InputDecoration(
                filled: false,
                border: InputBorder.none,
                hintText: 'Input the sub-task',
                hintStyle:
                    TextStyle(color: AppColors.darkGrey.withOpacity(0.5))),
          )) /*Text(
        widget.todo.content,
        style: TextStyle(
            color: widget.todo.isDone ? Colors.grey : Colors.black,
            decoration: widget.todo.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none),
      )*/
      ,
      leading: Container(
        // color: Colors.yellow,
        child: AnimateIcons(
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
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.close,
          // color: AppColors.bleuGrey,
          size: 15,
        ),
        onPressed: () => db.deleteTodo(widget.todo),
      ),
      onTap: () {},
    );
  }
}

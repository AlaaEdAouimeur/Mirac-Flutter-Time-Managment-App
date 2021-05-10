import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tyme/UI/Components/TodoTile.dart';

import 'package:tyme/models/Task.dart';
import 'package:tyme/models/Todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tyme/providers/tasksProvider.dart';
import 'package:tyme/utils/konstants.dart';

class TaskDetails extends StatefulWidget {
  final Task task;

  const TaskDetails({Key? key, required this.task}) : super(key: key);
  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails>
    with SingleTickerProviderStateMixin {
  AnimateIconController controller = AnimateIconController();
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
  }

  Widget _dateWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          child: Text(
            '12',
            style: TextStyle(fontSize: 41, fontWeight: FontWeight.bold),
          ),
          height: 50,
          width: 50,
        ),
        SizedBox(
          width: 8,
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('JAN'), Text('2016')],
          ),
          height: 50,
          width: 50,
        )
      ],
    );
  }

  Widget _headerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _dateWidget(),
        Container(
          padding: EdgeInsets.all(8),
          //  color: Colors.red,
          child: Text(
            "Sunday",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            _headerWidget(),
            ListView.builder(
                itemCount: widget.task.todosCount,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return TodoTile(
                    todo: widget.task.todos[index],
                    onPressed: () {
                      widget.task.todos[index].toggleTodo();
                    },
                  );
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}

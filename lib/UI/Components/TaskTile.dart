import 'package:flutter/material.dart';
import 'package:tyme/models/Task.dart';

class TaskTile extends StatelessWidget {
  final Task? task;

  const TaskTile({Key? key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 5,
          color: task?.color,
        ),
        Container(
          color: task?.color.withOpacity(0.3),
          height: 100,
          width: MediaQuery.of(context).size.width * 3 / 4,
          child: Column(
            children: [],
          ),
        )
      ],
    );
  }
}

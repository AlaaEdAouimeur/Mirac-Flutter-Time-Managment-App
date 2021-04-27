import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tyme/models/Task.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('kk:mm').format(
                    task.dateStart,
                  ),
                ),
                Text(
                  DateFormat('kk:mm').format(
                    task.dateEnd,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 100,
          width: 5,
          color: task.color,
        ),
        Container(
          color: task.color.withOpacity(0.2),
          height: 100,
          width: MediaQuery.of(context).size.width * 3 / 4,
          child: Column(
            children: [
              Text(
                task.title,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                task.note,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      task.category.iconData,
                      color: task.color,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      task.category.name,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

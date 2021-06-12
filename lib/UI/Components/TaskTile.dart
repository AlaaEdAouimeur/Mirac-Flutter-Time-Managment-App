import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tyme/UI/pages/TaskDetails.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/utils/konstants.dart';

// ignore: must_be_immutable
class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({Key? key, required this.task}) : super(key: key);
  late Categorie categorie;
  @override
  Widget build(BuildContext context) {
    // ignore: omit_local_variable_types
    categorie = categories.firstWhere((element) => element.id == task.category);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TaskDetails(
                  task: task,
                )));
      },
      key: Key('${Random.secure().nextInt(5)}'),
      child: Row(
        children: [
          Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('kk:mm').format(task.dueDate),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            width: 5,
            color: Color(categorie.color),
          ),
          Container(
            color: Color(categorie.color).withOpacity(0.1),
            height: 100,
            width: MediaQuery.of(context).size.width * 3 / 4,
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
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
                        IconData(categorie.iconData,
                            fontFamily: 'MaterialIcons'),
                        color: Color(categorie.color),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        categorie.content,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: Container()),
                      /*  task.todosCount != 0
                          ? Text(task.doneTodosCount.toString() +
                              "/" +
                              task.todosCount.toString() +
                              " Todos")
                          : Text('No todos yet'),*/
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

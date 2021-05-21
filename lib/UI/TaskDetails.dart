import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tyme/UI/Components/TodoTile.dart';

import 'package:tyme/database/database.dart';
import 'package:tyme/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tyme/main.dart';
import 'package:tyme/providers/tasksProvider.dart';
import 'package:tyme/utils/dateUtils.dart';
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
  Categorie? _selectedCategory;
  @override
  void initState() {
    gets();
    super.initState();
  }

  Widget _dateWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          child: Text(
            kToday.day.toString(),
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
            children: [
              Text(DateFormat('MMMM').format(kToday)),
              Text(kToday.year.toString())
            ],
          ),
          height: 50,
          width: 50,
        )
      ],
    );
  }

  Widget _headerWidget() {
    print(categories);
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        DropdownButton<Categorie>(
          value: _selectedCategory,
          onChanged: (cate) {},
          items: [
            ...categories
                .map((e) => DropdownMenuItem<Categorie>(
                      child: Container(
                        height: 70,
                        width: 80,
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          leading: Icon(
                            IconData(e.iconData, fontFamily: 'MaterialIcons'),
                            color: Colors.black,
                          ),
                          title: Text(e.content),
                        ),
                      ),
                    ))
                .toList(),
          ],
        ),
        /*_dateWidget(),
        Container(
          padding: EdgeInsets.all(8),
          //  color: Colors.red,
          child: Text(
            DateFormat(DateFormat.DAY).format(kToday),
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
          ),
        )*/
      ],
    );
    print('ds');
  }

  void gets() async {
    List<Todo> todos = await db.getAllTodos();
    print(todos.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          //TODO ADD THE THREE DOTS
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //  _headerWidget(),
              StreamBuilder(
                stream: db.watchAllTodos(widget.task.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData)
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return TodoTile(
                              todo: snapshot.data[index],
                              onPressed: () {
                                Todo todo = snapshot.data[index];

                                db.updateTodo(
                                    todo.copyWith(isDone: !todo.isDone));
                              });
                        });
                  else
                    return Text('sad');
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        db.insertTodo(
            TodosCompanion.insert(content: 'Eat Food', taskId: widget.task.id));
      }),
    );
  }
}

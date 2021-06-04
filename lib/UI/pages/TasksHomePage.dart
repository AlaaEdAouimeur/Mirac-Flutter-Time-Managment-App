import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tyme/UI/pages/CategoriesList.dart';
import 'package:tyme/UI/pages/TaskDetails.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/main.dart';
import 'package:tyme/utils/konstants.dart';

class TasksHomePage extends StatefulWidget {
  @override
  _TasksHomePageState createState() => _TasksHomePageState();
}

class _TasksHomePageState extends State<TasksHomePage> {
  int _chipIndex = -1;
  Widget _buildChips() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
          width: MediaQuery.of(context).size.width - 55,
          height: 50,
          child: ListView.builder(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _chipIndex = i;
                        });
                      },
                      child: Chip(
                        label: Text(
                          categories[i].content,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _chipIndex == i
                                  ? Colors.white
                                  : Colors.black54),
                        ),
                        backgroundColor: _chipIndex == i
                            ? Colors.blue.shade300
                            : AppColors.trafficWhite,
                      ),
                    ),
                  )),
        ),
        Expanded(
            child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CategoriesList()));
          },
          child: Container(
            height: 50,
            child: Icon(
              Icons.category,
              color: AppColors.darkGrey,
            ),
          ),
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildChips(),
        Divider(),
        Expanded(
          child: StreamBuilder(
            stream: _chipIndex == -1
                ? db.watchAllTasks()
                : db.watchTasksByCategory(_chipIndex),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<Task> _tasks = snapshot.data;
                if (_tasks.isEmpty)
                  return Text('Its empty here');
                else
                  return ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TaskDetails(
                                    task: _tasks[i],
                                  )));
                        },
                        child: Card(
                          margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                          elevation: 0,
                          color: AppColors.trafficWhite,
                          child: ListTile(
                            leading: Checkbox(
                              activeColor: AppColors.darkGrey,
                              value: _tasks[i].isDone,
                              onChanged: (f) {
                                db.updateTask(_tasks[i].copyWith(isDone: f));
                              },
                            ),
                            title: Text(_tasks[i].title),
                          ),
                        ),
                      );
                    },
                  );
              } else if (snapshot.connectionState == ConnectionState.waiting)
                return SpinKitThreeBounce(
                  color: Colors.blue.shade700,
                );
              else
                return Text('');
            },
          ),
        ),
      ],
    );
  }
}

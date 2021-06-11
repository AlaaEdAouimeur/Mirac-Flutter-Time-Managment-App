import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tyme/UI/Components/BarGraphs.dart';
import 'package:tyme/UI/Components/ScoreGauge.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/main.dart';

import 'package:tyme/utils/konstants.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  Expanded _numberWidget(String label, String number) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.trafficWhite,
        ),
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                number,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Text(label)
            ],
          ),
        ),
      ),
    );
  }

  Widget _scoreWidget() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.trafficWhite,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: ScoreGauge(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<User>(
            stream: db.watchUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinKitChasingDots(
                  color: Colors.blue,
                );
              } else if (snapshot.hasData) {
                var user = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /*  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            user!.firstName + ' ' + user.lastName,
                            style: TextStyle(fontSize: 30),
                          )
                        ],
                      ),
                    ),*/
                    _scoreWidget(),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Tasks Overview',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              _numberWidget('Done Tasks',
                                  user!.completedTasks.toString()),
                              _numberWidget(
                                  'Pending Tasks', user.pendingTasks.toString())
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Tasks Graph',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            //  height: 200,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 0,
                                ),
                                BarGraphs(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
              return SpinKitChasingDots(
                color: Colors.blue,
              );
            }),
      ),
    );
  }
}

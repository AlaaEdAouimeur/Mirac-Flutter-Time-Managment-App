import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/main.dart';
import 'package:tyme/utils/konstants.dart';

class BarGraphs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarGraphsState();
}

class BarGraphsState extends State<BarGraphs> {
  late List<PastTask> pastTasks;
  @override
  void initState() {
    super.initState();
  }

  double getCount(DateTime dateTime) {
    return pastTasks
        .where((element) =>
            element.dateFinished.day == dateTime.day &&
            element.dateFinished.month == dateTime.month &&
            element.dateFinished.year == dateTime.year)
        .length
        .toDouble();
  }

  List<DateTime> getDates(DateTime firstDay) {
    List<DateTime> dateList = [];
    for (int i = 0; i < 7; i++) {
      DateTime d = firstDay.add(Duration(days: i));
      dateList.add(d);
    }
    return dateList;
  }

  List<double> getData() {
    List<double> values = [];
    List<DateTime> _dates =
        getDates(DateTime.now().subtract(Duration(days: 4)));
    _dates.forEach((date) {
      values.add(getCount(date));
    });
    return values;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: AppColors.trafficWhite,
        child: StreamBuilder<List<PastTask>>(
            stream: db.getPastTasks(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('No data');
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                pastTasks = snapshot.data ?? [];
                return BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 20,
                    barTouchData: BarTouchData(
                      enabled: false,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipPadding: const EdgeInsets.all(0),
                        tooltipMargin: 8,
                        getTooltipItem: (
                          BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,
                        ) {
                          return BarTooltipItem(
                            rod.y.round().toString(),
                            TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (value) => const TextStyle(
                            color: Color(0xff7589a2),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 20,
                        getTitles: (double value) {
                          switch (value.toInt()) {
                            case 0:
                              return 'Mn';
                            case 1:
                              return 'Te';
                            case 2:
                              return 'Wd';
                            case 3:
                              return 'Tu';
                            case 4:
                              return 'Fr';
                            case 5:
                              return 'St';
                            case 6:
                              return 'Sn';
                            default:
                              return '';
                          }
                        },
                      ),
                      leftTitles: SideTitles(showTitles: false),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(y: getData()[0], colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(y: getData()[1], colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(y: getData()[2], colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(y: getData()[3], colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(y: getData()[4], colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ]),
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(y: getData()[5], colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                    ],
                  ),
                );
              } else
                return SpinKitThreeBounce(
                  color: Colors.blue,
                );
            }),
      ),
    );
  }
}

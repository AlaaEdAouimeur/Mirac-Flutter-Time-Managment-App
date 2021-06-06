import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/main.dart';
import 'package:tyme/utils/dateUtils.dart';
import 'package:tyme/utils/konstants.dart';

class BarGraphs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarGraphsState();
}

class BarGraphsState extends State<BarGraphs> {
  late List<PastTask> pastTasks;

  DateTimeRange dateTimeRange = new DateTimeRange(
      start: DateTime.now().subtract(Duration(days: 7)), end: DateTime.now());
  @override
  void initState() {
    super.initState();
  }

  void _handleBackIcon() {
    setState(() {
      dateTimeRange = DateTimeRange(
          start: dateTimeRange.start.subtract(Duration(days: 7)),
          end: dateTimeRange.end.subtract(Duration(days: 7)));
      getData();
    });
  }

  bool get canMoveForward => !(dateTimeRange.end.day == kToday.day &&
      dateTimeRange.end.month == kToday.month);
  void _handleForwordIcon() {
    canMoveForward
        ? setState(() {
            dateTimeRange = DateTimeRange(
                start: dateTimeRange.start.add(Duration(days: 7)),
                end: dateTimeRange.end.add(Duration(days: 7)));
            getData();
          })
        : null;
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

  List<DateTime> getDates() {
    List<DateTime> dateList = [];

    for (int i = 1; i <= 7; i++) {
      DateTime d = dateTimeRange.start.add(Duration(days: i));
      dateList.add(d);
    }
    return dateList;
  }

  List<double> getData() {
    List<double> values = [];
    List<DateTime> _datesList = getDates();
    _datesList.forEach((date) {
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
                return Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(Icons.arrow_back_ios_rounded),
                                  onPressed: _handleBackIcon,
                                ),
                                Text(DateFormat('d/M')
                                        .format(dateTimeRange.start) +
                                    ' - ' +
                                    DateFormat('d/M')
                                        .format(dateTimeRange.end)),
                                canMoveForward
                                    ? IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(
                                            Icons.arrow_forward_ios_rounded),
                                        onPressed: _handleForwordIcon)
                                    : IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.transparent,
                                        ),
                                        onPressed: null)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        child: BarChart(
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
                                  return DateFormat('EEE')
                                      .format(getDates()[value.toInt()]);
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
                                //     showingTooltipIndicators: [0],
                              ),
                              BarChartGroupData(
                                x: 1,
                                barRods: [
                                  BarChartRodData(y: getData()[1], colors: [
                                    Colors.lightBlueAccent,
                                    Colors.greenAccent
                                  ])
                                ],
                              ),
                              BarChartGroupData(
                                x: 2,
                                barRods: [
                                  BarChartRodData(y: getData()[2], colors: [
                                    Colors.lightBlueAccent,
                                    Colors.greenAccent
                                  ])
                                ],
                              ),
                              BarChartGroupData(
                                x: 3,
                                barRods: [
                                  BarChartRodData(y: getData()[3], colors: [
                                    Colors.lightBlueAccent,
                                    Colors.greenAccent
                                  ])
                                ],
                              ),
                              BarChartGroupData(
                                x: 4,
                                barRods: [
                                  BarChartRodData(y: getData()[4], colors: [
                                    Colors.lightBlueAccent,
                                    Colors.greenAccent
                                  ]),
                                ],
                              ),
                              BarChartGroupData(
                                x: 5,
                                barRods: [
                                  BarChartRodData(y: getData()[5], colors: [
                                    Colors.lightBlueAccent,
                                    Colors.greenAccent
                                  ])
                                ],
                              ),
                              BarChartGroupData(
                                x: 6,
                                barRods: [
                                  BarChartRodData(y: getData()[6], colors: [
                                    Colors.lightBlueAccent,
                                    Colors.greenAccent
                                  ])
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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

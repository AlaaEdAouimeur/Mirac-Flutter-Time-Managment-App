/// Flutter package imports
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Gauge imports
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/main.dart';

/// Local imports

class ScoreGauge extends StatefulWidget {
  @override
  _ScoreGaugeState createState() => _ScoreGaugeState();
}

class _ScoreGaugeState extends State<ScoreGauge> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      // change marker value based on orientation for the UI that looks good.

      _markerValue = 136;
    });
    return _buildDistanceTrackerExample();
  }

  /// Returns the gauge distance tracker
  Widget _buildDistanceTrackerExample() {
    return StreamBuilder<User>(
        stream: db.watchUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SpinKitThreeBounce(
              color: Colors.blue,
            );
          } else if (snapshot.hasData) {
            return SfRadialGauge(
              enableLoadingAnimation: true,
              axes: <RadialAxis>[
                RadialAxis(
                    showLabels: false,
                    endAngle: 270,
                    startAngle: 270,
                    showTicks: false,
                    radiusFactor: 0.8,
                    minimum: 0,
                    maximum: 200,
                    axisLineStyle: AxisLineStyle(
                        cornerStyle: CornerStyle.startCurve, thickness: 5),
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          angle: 90,
                          positionFactor: 0,
                          widget: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width: 180,
                                child: Center(
                                  child: Text(
                                      "${snapshot.data!.firstName}'s Score",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 22)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  snapshot.data!.score.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              )
                            ],
                          )),
                    ],
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: 142,
                        width: 18,
                        pointerOffset: -6,
                        cornerStyle: CornerStyle.bothCurve,
                        color: const Color(0xFFF67280),
                        gradient: const SweepGradient(colors: <Color>[
                          Colors.lightBlueAccent,
                          Colors.greenAccent
                        ], stops: <double>[
                          0.25,
                          0.75
                        ]),
                      ),
                      MarkerPointer(
                        value: _markerValue,
                        color: Colors.white,
                        markerType: MarkerType.circle,
                      ),
                    ]),
              ],
            );
          }
          return Text('ERROR');
        });
  }

  double _markerValue = 138;
}

import 'package:flutter/material.dart';
import 'package:thesis_prototype_app/screens/sensor_status.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Evaluation extends StatefulWidget {
  const Evaluation({Key? key}) : super(key: key);

  @override
  State<Evaluation> createState() => _EvaluationState();
}

class _EvaluationState extends State<Evaluation>
    with AutomaticKeepAliveClientMixin<Evaluation> {
  @override
  bool get wantKeepAlive => true;

  int stage = 0;
  Widget _screen =
      const Center(child: Text("Click the button below to check clogging"));

  // List<Widget> screens = [
  //   Text("No clogging detected by the sensors"),
  //   Column(
  //     children: [
  //       TimelineTile(
  //         beforeLineStyle: LineStyle(color: Colors.red),
  //         afterLineStyle: LineStyle(color: Colors.grey),
  //         alignment: TimelineAlign.manual,
  //         lineXY: 0.3,
  //         endChild: Container(
  //           constraints: const BoxConstraints(
  //             minHeight: 120,
  //           ),
  //           child: Center(
  //               child: Text(
  //             "First to get clogged",
  //             style: TextStyle(),
  //           )),
  //         ),
  //         startChild: Container(
  //           child: Center(child: Text("Sensor 1")),
  //         ),
  //       ),
  //       TimelineTile(
  //         alignment: TimelineAlign.manual,
  //         lineXY: 0.3,
  //         // beforeLineStyle: LineStyle(color: Colors.red),
  //         // afterLineStyle: LineStyle(color: Colors.grey),
  //         endChild: Container(
  //           constraints: const BoxConstraints(
  //             minHeight: 120,
  //           ),
  //           child: Center(
  //               child: Text(
  //             "Next to get clogged",
  //             style: TextStyle(),
  //           )),
  //         ),
  //         startChild: Container(
  //           child: Center(child: Text("Sensor 2")),
  //         ),
  //       ),
  //       TimelineTile(
  //         alignment: TimelineAlign.manual,
  //         lineXY: 0.3,
  //         endChild: Container(
  //           constraints: const BoxConstraints(
  //             minHeight: 120,
  //           ),
  //           child: Center(
  //               child: Text(
  //             "Last to get clogged",
  //             style: TextStyle(),
  //           )),
  //         ),
  //         startChild: Container(
  //           child: Center(child: Text("Sensor 3")),
  //         ),
  //       ),
  //       Padding(
  //           padding: EdgeInsets.fromLTRB(30, 50, 30, 10),
  //           child: Text(
  //               "Clogging might have occured at the red color on the line"))
  //     ],
  //   ),
  //   Column(
  //     children: [
  //       TimelineTile(
  //         // beforeLineStyle: LineStyle(color: Colors.red),
  //         afterLineStyle: LineStyle(color: Colors.red),
  //         alignment: TimelineAlign.manual,
  //         lineXY: 0.3,
  //         endChild: Container(
  //           constraints: const BoxConstraints(
  //             minHeight: 120,
  //           ),
  //           child: Center(
  //               child: Text(
  //             "First to get clogged",
  //             style: TextStyle(),
  //           )),
  //         ),
  //         startChild: Container(
  //           child: Center(child: Text("Sensor 1")),
  //         ),
  //       ),
  //       TimelineTile(
  //         alignment: TimelineAlign.manual,
  //         lineXY: 0.3,
  //         beforeLineStyle: LineStyle(color: Colors.red),
  //         afterLineStyle: LineStyle(color: Colors.grey),
  //         endChild: Container(
  //           constraints: const BoxConstraints(
  //             minHeight: 120,
  //           ),
  //           child: Center(
  //               child: Text(
  //             "Next to get clogged",
  //             style: TextStyle(),
  //           )),
  //         ),
  //         startChild: Container(
  //           child: Center(child: Text("Sensor 2")),
  //         ),
  //       ),
  //       TimelineTile(
  //         alignment: TimelineAlign.manual,
  //         lineXY: 0.3,
  //         endChild: Container(
  //           constraints: const BoxConstraints(
  //             minHeight: 120,
  //           ),
  //           child: Center(
  //               child: Text(
  //             "Last to get clogged",
  //             style: TextStyle(),
  //           )),
  //         ),
  //         startChild: Container(
  //           child: Center(child: Text("Sensor 3")),
  //         ),
  //       ),
  //       Padding(
  //           padding: EdgeInsets.fromLTRB(30, 50, 30, 10),
  //           child: Text(
  //               "Clogging might have occured at the red color on the line"))
  //     ],
  //   ),
  //   Column(
  //     children: [
  //       TimelineTile(
  //         // beforeLineStyle: LineStyle(color: Colors.red),
  //         // afterLineStyle: LineStyle(color: Colors.red),
  //         alignment: TimelineAlign.manual,
  //         lineXY: 0.3,
  //         endChild: Container(
  //           constraints: const BoxConstraints(
  //             minHeight: 120,
  //           ),
  //           child: Center(
  //               child: Text(
  //             "First to get clogged",
  //             style: TextStyle(),
  //           )),
  //         ),
  //         startChild: Container(
  //           child: Center(child: Text("Sensor 1")),
  //         ),
  //       ),
  //       TimelineTile(
  //         alignment: TimelineAlign.manual,
  //         lineXY: 0.3,
  //         // beforeLineStyle: LineStyle(color: Colors.red),
  //         // afterLineStyle: LineStyle(color: Colors.grey),
  //         endChild: Container(
  //           constraints: const BoxConstraints(
  //             minHeight: 120,
  //           ),
  //           child: Center(
  //               child: Text(
  //             "Next to get clogged",
  //             style: TextStyle(),
  //           )),
  //         ),
  //         startChild: Container(
  //           child: Center(child: Text("Sensor 2")),
  //         ),
  //       ),
  //       TimelineTile(
  //         alignment: TimelineAlign.manual,
  //         afterLineStyle: LineStyle(color: Colors.red),
  //         lineXY: 0.3,
  //         endChild: Container(
  //           constraints: const BoxConstraints(
  //             minHeight: 120,
  //           ),
  //           child: Center(
  //               child: Text(
  //             "Last to get clogged",
  //             style: TextStyle(),
  //           )),
  //         ),
  //         startChild: Container(
  //           child: Center(child: Text("Sensor 3")),
  //         ),
  //       ),
  //       Padding(
  //           padding: EdgeInsets.fromLTRB(30, 50, 30, 10),
  //           child: Text(
  //               "Clogging might have occured at the red color on the line"))
  //     ],
  //   )
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: _screen,
          ),
        ),
        ElevatedButton(
          child: const Text("Check the clog"),
          onPressed: () {
            // setState(() {
            //   stage++;
            //   if (stage > 3) {
            //     stage = 0;
            //   }
            // });
            if (SensorReadings.sensor1 == null) {
              setState(() {
                _screen = const Center(child: Text("There is no Clogging"));
              });
            } else if (SensorReadings.sensor1! < 1 &&
                SensorReadings.sensor2! >= 1 &&
                SensorReadings.sensor3! >= 1) {
              setState(() {
                _screen = _getFirstScene();
              });
            } else if (SensorReadings.sensor1! < 1 &&
                SensorReadings.sensor2! < 1 &&
                SensorReadings.sensor3! >= 1) {
              setState(() {
                _screen = _getFirstScene2();
              });
            } else if (SensorReadings.sensor1! < 1 &&
                SensorReadings.sensor2! < 1 &&
                SensorReadings.sensor3! < 1) {
              setState(() {
                _screen = _getThirdScene();
              });
            }
          },
        )
      ],
    );
  }

  Column _getFirstScene() {
    return Column(
      children: [
        TimelineTile(
          beforeLineStyle: const LineStyle(color: Colors.red),
          afterLineStyle: const LineStyle(color: Colors.red),
          alignment: TimelineAlign.manual,
          lineXY: 0.3,
          endChild: Container(
            constraints: const BoxConstraints(
              minHeight: 120,
            ),
            child: Center(
                child: Text(
              "${SensorReadings.sensor1} ml/s",
            )),
          ),
          startChild: const Center(child: Text("Sensor 1")),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.3,
          beforeLineStyle: const LineStyle(color: Colors.red),
          afterLineStyle: const LineStyle(color: Colors.grey),
          endChild: Container(
            constraints: const BoxConstraints(
              minHeight: 120,
            ),
            child: Center(
                child: Text(
              "${SensorReadings.sensor2} ml/s",
            )),
          ),
          startChild: const Center(child: Text("Sensor 2")),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.3,
          endChild: Container(
            constraints: const BoxConstraints(
              minHeight: 120,
            ),
            child: Center(
                child: Text(
              "${SensorReadings.sensor3} ml/s",
            )),
          ),
          startChild: const Center(child: Text("Sensor 3")),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
            child: Column(
              children: const [
                Text(
                    "Clogging might have occured at the red color on the line"),
                SizedBox(height: 20),
                Text(
                  "Note: if the hardware system is inactive on app start, the screen above is inaacurate",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ))
      ],
    );
  }

  Column _getFirstScene2() {
    return Column(
      children: [
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.3,
          endChild: Container(
            constraints: const BoxConstraints(
              minHeight: 120,
            ),
            child: Center(
                child: Text(
              "${SensorReadings.sensor1} ml/s",
            )),
          ),
          startChild: const Center(child: Text("Sensor 1")),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.3,
          // beforeLineStyle: LineStyle(color: Colors.red),
          afterLineStyle: const LineStyle(color: Colors.red),
          endChild: Container(
            constraints: const BoxConstraints(
              minHeight: 120,
            ),
            child: Center(
                child: Text(
              "${SensorReadings.sensor2} ml/s",
            )),
          ),
          startChild: const Center(child: Text("Sensor 2")),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          beforeLineStyle: const LineStyle(color: Colors.red),
          afterLineStyle: const LineStyle(color: Colors.grey),
          lineXY: 0.3,
          endChild: Container(
            constraints: const BoxConstraints(
              minHeight: 120,
            ),
            child: Center(
                child: Text(
              "${SensorReadings.sensor3} ml/s",
            )),
          ),
          startChild: const Center(child: Text("Sensor 3")),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
            child: Column(
              children: const [
                Text(
                    "Clogging might have occured at the red color on the line"),
                SizedBox(height: 20),
                Text(
                  "Note: if the hardware system is inactive on app start, the screen above is inaacurate",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ))
      ],
    );
  }

  Column _getThirdScene() {
    return Column(
      children: [
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.3,
          endChild: Container(
            constraints: const BoxConstraints(
              minHeight: 120,
            ),
            child: Center(
                child: Text(
              "${SensorReadings.sensor1} ml/s",
            )),
          ),
          startChild: const Center(child: Text("Sensor 1")),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.3,
          // beforeLineStyle: LineStyle(color: Colors.red),
          // afterLineStyle: const LineStyle(color: Colors.red),
          endChild: Container(
            constraints: const BoxConstraints(
              minHeight: 120,
            ),
            child: Center(
                child: Text(
              "${SensorReadings.sensor2} ml/s",
            )),
          ),
          startChild: const Center(child: Text("Sensor 2")),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          beforeLineStyle: const LineStyle(color: Colors.grey),
          afterLineStyle: const LineStyle(color: Colors.red),
          lineXY: 0.3,
          endChild: Container(
            constraints: const BoxConstraints(
              minHeight: 120,
            ),
            child: Center(
                child: Text(
              "${SensorReadings.sensor3} ml/s",
            )),
          ),
          startChild: const Center(child: Text("Sensor 3")),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
            child: Column(
              children: const [
                Text(
                    "Clogging might have occured at the red color on the line"),
                SizedBox(height: 20),
                Text(
                  "Note: if the hardware system is inactive on app start, the screen above is inaacurate",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ))
      ],
    );
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:thesis_prototype_app/components/readings_tile.dart';
import 'package:thesis_prototype_app/constants.dart';
import 'package:thesis_prototype_app/data_dao.dart';
import 'package:thesis_prototype_app/models/sensor_readings_model.dart';

class SensorReadings extends StatefulWidget {
  SensorReadings({Key? key}) : super(key: key);

  static double? sensor1;
  static double? sensor2;
  static double? sensor3;

  final MessageDao dao = MessageDao();

  @override
  State<SensorReadings> createState() => _SensorReadingsState();
}

class _SensorReadingsState extends State<SensorReadings>
    with AutomaticKeepAliveClientMixin {
  // late Stream<DatabaseEvent> stream1; // sensor 1 stream
  // late Stream<DatabaseEvent> stream2; // sensor 2 stream
  // late Stream<DatabaseEvent> stream3; // sensor 3 stream

  late Stream<DatabaseEvent> sensorsStream; // sensor 3 stream

  double _sensor1Reading = 0.0;
  double _sensor2Reading = 0.0;
  double _sensor3Reading = 0.0;

  late Stream<DatabaseEvent>
      alternateRouteStream; // alternate route status stream
  bool? _alternateRouteOn;

  @override
  void initState() {
    super.initState();
    _initializeAlternateRouteStatus();

    // stream1 = widget.dao.getSensor1Data();
    // stream2 = widget.dao.getSensor2Data();
    // stream3 = widget.dao.getSensor3Data();

    sensorsStream = widget.dao.getSensorsData();
    alternateRouteStream = widget.dao.getAlternateRouteData();

    // stream1.listen(_activateListener1);
    // stream2.listen(_activateListener2);
    // stream3.listen(_activateListener3);

    sensorsStream.listen(_activateSensorsListener);
    alternateRouteStream.listen(_activateAlternateRouteListener);
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ############## ACTUATOR FUNCTIONS ##############
  void _initializeAlternateRouteStatus() async {
    bool temp = await widget.dao.getAlternateRouteStatus();
    if (mounted) {
      setState(() {
        _alternateRouteOn = temp;
      });
    }
  }

  void _activateAlternateRouteListener(DatabaseEvent event) {
    Map temp = event.snapshot.value as Map;
    if (mounted) {
      setState(() {
        _alternateRouteOn = temp["isClogged"];
      });
    }
  }

  // ############## SENSOR LISTENER ##############
  void _activateSensorsListener(DatabaseEvent event) {
    String temp = (event.snapshot.value as Map)["reading"];
    var values = temp.split("^");

    if (mounted) {
      setState(() {
        _sensor1Reading = double.parse(values[0]);
        _sensor2Reading = double.parse(values[1]);
        _sensor3Reading = double.parse(values[2]);
      });

      if (_sensor1Reading < 1 || _sensor2Reading < 1 || _sensor3Reading < 1) {
        if (SensorReadings.sensor1 == null) {
          SensorReadings.sensor1 = _sensor1Reading;
          SensorReadings.sensor2 = _sensor2Reading;
          SensorReadings.sensor3 = _sensor3Reading;
        }
      } else {
        SensorReadings.sensor1 = null;
        SensorReadings.sensor2 = null;
        SensorReadings.sensor3 = null;
      }
    }
  }

  // not used
  // // sensor1 listener
  // void _activateListener1(DatabaseEvent event) {
  //   SensorReadingModel model =
  //       SensorReadingModel.fromJson(event.snapshot.value as Map);
  //   setState(() {
  //     _sensor1Reading = model.reading;
  //   });
  // }

  // // sensor2 listener
  // void _activateListener2(DatabaseEvent event) {
  //   SensorReadingModel model =
  //       SensorReadingModel.fromJson(event.snapshot.value as Map);
  //   setState(() {
  //     _sensor2Reading = model.reading;
  //   });
  // }

  // // sensor1 listener
  // void _activateListener3(DatabaseEvent event) {
  //   SensorReadingModel model =
  //       SensorReadingModel.fromJson(event.snapshot.value as Map);
  //   setState(() {
  //     _sensor3Reading = model.reading;
  //   });
  // }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 7),
          ReadingsCard(
            id: 1,
            reading: _sensor1Reading,
            description: "Sensor 1",
          ),
          ReadingsCard(
            id: 2,
            reading: _sensor2Reading,
            description: "Sensor 2",
          ),
          ReadingsCard(
            id: 3,
            reading: _sensor3Reading,
            description: "Sensor 3",
          ),
          const SizedBox(height: 15),
          Text(
            "Alternate Route Status",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 23, color: kBlue),
          ),
          const SizedBox(height: 25),
          if (_alternateRouteOn != null)
            Text(
              _alternateRouteOn! ? "On" : "Off",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: _alternateRouteOn!
                      ? Colors.blue
                      : Colors.blueGrey.shade600),
            ),
          const SizedBox(height: 8),
          Transform.scale(
            scale: 2.5,
            child: _alternateRouteOn != null
                ? Switch(
                    // thumb color (round icon)
                    activeColor: Colors.blue,
                    activeTrackColor: Colors.grey.shade400,
                    inactiveThumbColor: Colors.blueGrey.shade600,
                    inactiveTrackColor: Colors.grey.shade400,
                    splashRadius: 50.0,

                    value: _alternateRouteOn!,

                    onChanged: (value) => setState(() {
                      widget.dao.changeActiveRouteStatus(value);
                      _alternateRouteOn = value;
                    }),
                  )
                : CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}

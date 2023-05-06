import 'package:flutter/material.dart';
import 'package:thesis_prototype_app/constants.dart';
import 'package:thesis_prototype_app/screens/data_evaluation.dart';
import 'package:thesis_prototype_app/screens/sensor_status.dart';

class ClogDetection extends StatefulWidget {
  const ClogDetection({Key? key}) : super(key: key);

  @override
  State<ClogDetection> createState() => _ClogDetectionState();
}

class _ClogDetectionState extends State<ClogDetection> {
  int _screen = 0;

  final List<Widget> _children = [
    SensorReadings(),
    const Evaluation(),
  ];

  final List<Widget> _titles = const [
    Text("Sensor Readings"),
    Text("Clogging")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlue,
        title: _titles[_screen],
        centerTitle: true,
      ),
      body: IndexedStack(
        children: _children,
        index: _screen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kBlue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            _screen = index;
          });
        },
        currentIndex: _screen,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Readings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Clogging',
          ),
        ],
      ),
    );
  }
}

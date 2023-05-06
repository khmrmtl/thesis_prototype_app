import 'package:flutter/material.dart';
import 'package:thesis_prototype_app/constants.dart';

class ReadingsCard extends StatelessWidget {
  const ReadingsCard({
    Key? key,
    required this.id,
    required this.reading,
    required this.description,
  }) : super(key: key);

  final int id;
  final double reading;
  final String description;

  Color getColor(double value) {
    return reading < 1 ? const Color.fromARGB(255, 249, 18, 1) : Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: Card(
        elevation: 3.0,
        color: kGrey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: getColor(reading),
                radius: 40.0,
                child: Text(
                  id.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${reading.toString()} ml/s",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  Text(
                    "$description ${reading < 1 ? " - no water flow" : ""}",
                    style: TextStyle(fontSize: 20, color: getColor(reading)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

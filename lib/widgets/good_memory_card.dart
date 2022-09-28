//import 'dart:html';

import 'package:flutter/material.dart';

class MemoryCard extends StatefulWidget {
  List<String> things;
  int happiness;
  String date;
  MemoryCard({
    Key? key,
    required this.things,
    required this.happiness,
    required this.date,
  }) : super(key: key);

  @override
  State<MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard> {
  List<Color?> happinessColors = [
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 255, 75, 0),
    Color.fromARGB(255, 255, 100, 0),
    Color.fromARGB(255, 255, 140, 0),
    Color.fromARGB(255, 255, 200, 0),
    Color.fromARGB(255, 255, 255, 0),
    Color.fromARGB(255, 200, 255, 0),
    Color.fromARGB(255, 150, 255, 0),
    Color.fromARGB(255, 75, 255, 0),
    Color.fromARGB(255, 0, 255, 64),
    Color.fromARGB(255, 0, 255, 64),
  ];

  @override
  Widget build(BuildContext context) {
    print(widget.things);
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 4,
        ),
        color: happinessColors[widget.happiness],
      ),
      child: Column(
        children: widget.things.map((element) {
          return ListTile(
            title: Text(
              element,
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 4,
            ),
          );
        }).toList(),
      ),
    );
  }
}

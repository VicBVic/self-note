import 'package:flutter/material.dart';

class MemoryCard extends StatefulWidget {
  List<String> things;
  int happiness;
  MemoryCard({
    Key? key,
    required this.things,
    required this.happiness,
  }) : super(key: key);

  @override
  State<MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard> {
  // List<Color?> happinessColors = [
  //   Color.lerp(Colors.red, Colors.green, 7.0),
  //   Color.fromARGB(255, 255, 0, 0),
  //   Color.fromARGB(255, 255, 0, 0),
  //   Color.fromARGB(255, 255, 0, 0),
  //   Color.fromARGB(255, 255, 0, 0),
  //   Color.fromARGB(255, 255, 217, 0),
  //   Color.fromARGB(255, 255, 0, 0),
  //   Color.fromARGB(255, 255, 0, 0),
  //   Color.fromARGB(255, 255, 0, 0),
  //   Color.fromARGB(255, 255, 0, 0),
  //   Color.fromARGB(255, 0, 255, 0),
  // ];

  @override
  Widget build(BuildContext context) {
    print(widget.things);
    return Card(
      color: Color.lerp(
          Colors.red, Colors.green, widget.happiness.toDouble() / 10),
      child: Column(
        children: widget.things.map((element) {
          return Text(element);
        }).toList(),
      ),
    );
  }
}

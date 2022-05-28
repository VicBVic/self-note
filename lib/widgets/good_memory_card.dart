import 'package:flutter/material.dart';

class MemoryCard extends StatefulWidget {
  List<String> things;
  MemoryCard({
    Key? key,
    required this.things,
  }) : super(key: key);

  @override
  State<MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: widget.things.map((element) {
          return Text(element);
        }).toList(),
      ),
    );
  }
}

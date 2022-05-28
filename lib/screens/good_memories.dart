import 'dart:html';

import 'package:flutter/material.dart';

class GoodMemos extends StatefulWidget {
  const GoodMemos({Key? key}) : super(key: key);

  @override
  State<GoodMemos> createState() => _GoodMemosState();
}

class _GoodMemosState extends State<GoodMemos> {
  List<Widget> cards = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cards,
    );
  }

  @override
  void initState() {
    loadCards();
  }

  void loadCards() async {
    //dummy
    setState(() {
      for (int i = 0; i < 100; i++) {
        cards.add(Card(
          child: Text("neata vere $i"),
        ));
      }
    });
  }
}

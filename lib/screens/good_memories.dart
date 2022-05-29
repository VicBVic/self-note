import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itec20222/robertstore.dart';
import 'package:itec20222/widgets/good_memory_card.dart';

class GoodMemos extends StatefulWidget {
  GoodMemos({Key? key}) : super(key: key);

  @override
  State<GoodMemos> createState() => _GoodMemosState();
}

class _GoodMemosState extends State<GoodMemos> {
  List<List<String>> s = [[]];
  @override
  Widget build(BuildContext context) {
    //print(mem);
    return FutureBuilder(
        future: Robertstore().fetchMemories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) loadCards(snapshot.data!);
          return ListView.builder(
            itemCount: s.length,
            itemBuilder: (context, index) {
              return MemoryCard(happiness: 5, things: s[index]);
            },
          );
        });
  }

  @override
  void initState() {
    //fe
  }

  void loadCards(List<Map<String, dynamic>> allData) {
    print("here");
    for (var e in allData) {
      s.add([e["thing1"], e["thing2"], e["thing3"]]);
    }
  }
}

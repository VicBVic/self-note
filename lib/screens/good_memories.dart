import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itec20222/robertstore.dart';
import 'package:itec20222/widgets/good_memory_card.dart';

class GoodMemos extends StatefulWidget {
  const GoodMemos({Key? key}) : super(key: key);

  @override
  State<GoodMemos> createState() => _GoodMemosState();
}

class _GoodMemosState extends State<GoodMemos> {
  List<Widget> cards = [
    Text(
        'Here you can see all your past good thoughts. Funny, wholesome or emotional, they can make your day!'),
    MemoryCard(
      things: ["pisica", "octa", "luca"],
      happiness: 5,
    ),
    MemoryCard(
      things: ["pisica2", "octa2", "luca2"],
      happiness: 10,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: cards),
    );
  }
  /*
  Future<void> fetchMemories() async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference collection =
        FirebaseFirestore.instance.collection(user!.uid);
    var snapshot = await collection.get();
    allData = snapshot.docs.map((doc) => doc.data()).toList();
  }
  */

  @override
  void initState() {
    //fetchMemories();
    //loadCards();
    Robertstore().fetchMemories().then((value) {
      loadCards(value);
    });
  }

  void loadCards(List<Object?> allData) {
    print("here");
    setState(() {
      allData.map((e) {
        print(e);
        var m = e!;
        cards.add(MemoryCard(
          things: ["bruh", "bruh", "bruh"],
          happiness: 0,
          //things: [m["thing1"], m["thing2"], m["thing3"]],
          //happiness:m ["happiness"],
        ));
      });
    });
  }
}

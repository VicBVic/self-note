import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itec20222/widgets/good_memory_card.dart';

class GoodMemos extends StatefulWidget {
  const GoodMemos({Key? key}) : super(key: key);

  @override
  State<GoodMemos> createState() => _GoodMemosState();
}

class _GoodMemosState extends State<GoodMemos> {
  List<Widget> cards = [];
  dynamic allData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text(
              'Here you can see all your past good thoughts. Funny, wholesome or emotional, they can make your day!'),
          // allData.map(context, (e) {
          //   return MemoryCard(
          //       things: [e["thing1"], e["thing2"], e["thing3"]],
          //       happiness: e["happiness"]);
          // }),
          MemoryCard(
            things: ["pisica", "octa", "luca"],
            happiness: 5,
          )
        ],
      ),
    );
  }

  Future<void> fetchMemories() async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference collection =
        FirebaseFirestore.instance.collection(user!.uid);
    var snapshot = await collection.get();
    allData = snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  void initState() {
    fetchMemories();
    loadCards();
  }

  void loadCards() async {
    setState(() {});
  }
}

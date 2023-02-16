import 'package:flutter/material.dart';
import 'package:itec20222/robertstore.dart';
import 'package:itec20222/widgets/good_memory_card.dart';

class GoodMemos extends StatefulWidget {
  GoodMemos({Key? key}) : super(key: key);

  @override
  State<GoodMemos> createState() => _GoodMemosState();
}

class _GoodMemosState extends State<GoodMemos> {
  List<List<String>> s = [];
  List<int> happlist = [];
  List<String> datele = [];
  @override
  Widget build(BuildContext context) {
    //print(mem);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Good Memories'),
      ),
      body: FutureBuilder(
          future: Robertstore().fetchMemories(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) loadCards(snapshot.data!);

            return SingleChildScrollView(
              child: Wrap(
                  children: List.generate(
                      s.length,
                      (index) => MemoryCard(
                            date: '2022',
                            happiness: happlist[index],
                            things: s[index],
                          ))),
            );
          }),
    );
  }

  @override
  void initState() {
    //fe
  }

  void loadCards(List<Map<String, dynamic>> allData) {
    for (var e in allData) {
      s.add([e["thing1"], e["thing2"], e["thing3"]]);
      happlist.add(e["happiness"]);
    }
  }
}

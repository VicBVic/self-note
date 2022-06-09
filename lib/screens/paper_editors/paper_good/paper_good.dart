import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itec20222/screens/paper_editors/paper_good/papergood_interactable.dart';
import 'package:itec20222/widgets/paragraph-provider.dart';
import 'package:itec20222/widgets/wavy_container.dart';

class PaperGood extends StatefulWidget {
  const PaperGood({
    Key? key,
    this.paragraphWaveHeight,
    this.paragraphWaveLength,
    this.paragraphWaveSpeed,
  }) : super(key: key);
  final double? paragraphWaveHeight;
  final double? paragraphWaveLength;
  final double? paragraphWaveSpeed;

  @override
  State<PaperGood> createState() => _PaperGoodState();
}

class _PaperGoodState extends State<PaperGood> {
  List<Widget> desc = [];

  @override
  Widget build(BuildContext context) {
    Widget PG = PaperGoodInteractable(
      paperHeight: 400,
      padding: 100,
    );
    TextStyle h1 = Theme.of(context).textTheme.headline2!;
    TextStyle b1 = Theme.of(context).textTheme.bodyLarge!;

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
              Padding(
                padding: EdgeInsets.fromLTRB(64, 16, 0, 32),
                child: Text(
                  'Not all is lightless still.',
                  style: h1.copyWith(
                      //decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 32),
                child: Text(
                    'Try and write down three things that made you happy troughout the day. Search in your memory thouroughly.',
                    style: b1.copyWith(
                        fontSize: 22.0, height: 1, color: Colors.black)),
              ),
              PG,
            ] +
            desc,
      ),
    );
  }

  void initState() {
    //editorOp = 0.0;
    loadDesc();
  }

  void loadDesc() async {
    //print("yep");
    await rootBundle.loadString('pagebad.json').then((value) {
      TextStyle h1 = Theme.of(context).textTheme.headline2!.copyWith(
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
          color: Colors.white);
      TextStyle h2 = Theme.of(context).textTheme.headline2!;
      TextStyle b1 = Theme.of(context).textTheme.bodyLarge!
        ..copyWith(fontSize: 22.0, height: 1.5);

      setState(() {
        const double defHeight = 50;
        const double defLen = 350;
        const double defSpeed = 1;
        var serialized = jsonDecode(value);
        desc.add(Padding(
            padding: EdgeInsets.symmetric(
                vertical: ((widget.paragraphWaveHeight ?? defHeight) + 8))));
        //print(serialized);
        for (var paragraph in serialized) {
          var argb = paragraph['Color'];
          desc.add(ParagraphProvider(
            data: paragraph,
            waveHeight: widget.paragraphWaveHeight,
            waveLength: widget.paragraphWaveLength,
            waveSpeed: widget.paragraphWaveSpeed,
          ));
        }
      });
    });
  }
}

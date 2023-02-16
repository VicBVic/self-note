import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itec20222/screens/paper_editors/paper_good/papergood_interactable.dart';
import 'package:itec20222/screens/paper_editors/paper_good/papergood_utility.dart';
import 'package:itec20222/widgets/paragraph-provider.dart';

import '../../../animations/animated_wavy_container.dart';
import '../../../widgets/parallax_sliver.dart';

class PaperGoodMenu extends StatefulWidget {
  const PaperGoodMenu({
    Key? key,
    this.paragraphWaveHeight,
    this.paragraphWaveLength,
    this.paragraphWaveSpeed,
  }) : super(key: key);
  final double? paragraphWaveHeight;
  final double? paragraphWaveLength;
  final double? paragraphWaveSpeed;

  @override
  State<PaperGoodMenu> createState() => _PaperGoodMenuState();
}

class _PaperGoodMenuState extends State<PaperGoodMenu> {
  List<Widget> desc = [];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
            SliverFillViewport(
                delegate: SliverChildListDelegate(
              [Container(color: Colors.white, child: PaperGoodUtility())],
            ))
          ] +
          desc,
    );
  }

  void initState() {
    //editorOp = 0.0;
    loadDesc();
  }

  void loadDesc() async {
    //print("yep");
    await rootBundle.loadString('jsons/pagebad.json').then((value) {
      TextStyle h1 = Theme.of(context).textTheme.headline2!.copyWith(
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
          color: Colors.white);
      TextStyle h2 = Theme.of(context).textTheme.headline2!;
      TextStyle b1 = Theme.of(context).textTheme.bodyLarge!
        ..copyWith(fontSize: 22.0, height: 1.5);

      setState(() {
        var serialized = jsonDecode(value);
        for (var paragraph in serialized) {
          var argb = paragraph['Color'];
          desc.add(ParallaxSliver(
            child: AnimatedWavyContainer(
              color: Color.fromARGB(argb[0], argb[1], argb[2], argb[3]),
              child: ParagraphProvider(
                data: paragraph,
              ),
            ),
          ));
        }
      });
    });
  }
}

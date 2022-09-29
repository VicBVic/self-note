import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:itec20222/consts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:itec20222/screens/paper_editors/paper_bad/paperbad_interactable.dart';
import 'package:itec20222/widgets/footer.dart';
import 'package:itec20222/widgets/paragraph-provider.dart';
import 'package:itec20222/widgets/wavy_container.dart';

class PaperBad extends StatefulWidget {
  const PaperBad({
    Key? key,
    this.paragraphWaveHeight,
    this.paragraphWaveLength,
    this.paragraphWaveSpeed,
    required this.onBurned,
  }) : super(key: key);
  final double? paragraphWaveHeight;
  final double? paragraphWaveLength;
  final double? paragraphWaveSpeed;
  final Function onBurned;

  @override
  State<PaperBad> createState() => _PaperBadState();
}

class _PaperBadState extends State<PaperBad> {
  double editorOp = 1.0;
  bool burning = false;
  List<Widget> desc = [];
  StreamController<bool> controller = StreamController<bool>();

  @override
  Widget build(BuildContext context) {
    TextStyle h1 = Theme.of(context).textTheme.headline2!.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
            Center
            (
              child: Text(
              'Write your negative thoughts on the paper below:',
              style: h1,
              ),
            ),
            AnimatedOpacity(
              duration: Duration(seconds: 2),
              opacity: editorOp,
              child: PaperBadInteractable(
                onBurned: widget.onBurned,
                forMobile: (screenHeight > screenWidth),
                burning: burning,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 300.0, vertical: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    burning = true;
                    //sleep(Duration(seconds: 4));
                    isBad = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Burn',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
            ),
          ] +
          desc,
    );
  }

  @override
  void initState() {
    editorOp = 0.0;
    loadDesc();
    Future.delayed(Duration(milliseconds: 300), () {
      editorOp = 1;
    }).then((value) => print(value));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        editorOp = 1;
      });
    });
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

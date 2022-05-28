import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:itec20222/screens/paper_bad/paperbad_interactable.dart';
import 'package:itec20222/widgets/footer.dart';
import 'package:itec20222/widgets/wavy_container.dart';

class PaperBad extends StatefulWidget {
  const PaperBad(
      {Key? key,
      this.paragraphWaveHeight,
      this.paragraphWaveLength,
      this.paragraphWaveSpeed})
      : super(key: key);
  final double? paragraphWaveHeight;
  final double? paragraphWaveLength;
  final double? paragraphWaveSpeed;

  @override
  State<PaperBad> createState() => _PaperBadState();
}

class _PaperBadState extends State<PaperBad> {
  List<Widget> desc = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
            const PaperBadInteractable(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 300.0, vertical: 20.0),
              child: ElevatedButton(
                onPressed: () {},
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
    loadDesc();
  }

  void loadDesc() async {
    //print("yep");
    await rootBundle.loadString('pagebad.json').then((value) {
      TextStyle h1 = Theme.of(context).textTheme.headline2!;
      TextStyle h2 = Theme.of(context).textTheme.headline2!;
      TextStyle b1 = Theme.of(context).textTheme.bodyLarge!;

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
          desc.add(WavyContainer(
            height: paragraph['Height'],
            width: double.infinity,
            waveProcent: 1.0 +
                (widget.paragraphWaveHeight ??
                    defHeight / (paragraph['Height'])),
            waveHeight: widget.paragraphWaveHeight ?? defHeight,
            waveLength: widget.paragraphWaveLength ?? defLen,
            waveSpeed: widget.paragraphWaveSpeed ?? defSpeed,
            color: Color.fromARGB(argb[0], argb[1], argb[2], argb[3]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(64,
                      (widget.paragraphWaveHeight ?? defHeight) + 16, 0, 64),
                  child: Text(
                    paragraph['Title'],
                    style: h1.copyWith(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 32),
                  child: Text(paragraph['Content'],
                      style: b1.copyWith(fontSize: 22.0, height: 1.5)),
                ),
              ],
            ),
          ));
        }
      });
    });
  }
}

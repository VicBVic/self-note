import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:itec20222/screens/paper_editors/paper_bad/paperbad_interactable.dart';
import 'package:itec20222/widgets/badgood_controller.dart';
import 'package:itec20222/widgets/paragraph-provider.dart';

class PaperBadMenu extends StatefulWidget {
  const PaperBadMenu({
    Key? key,
    this.paragraphWaveHeight,
    this.paragraphWaveLength,
    this.paragraphWaveSpeed,
    required this.badgoodController,
  }) : super(key: key);
  final BadgoodController badgoodController;
  final double? paragraphWaveHeight;
  final double? paragraphWaveLength;
  final double? paragraphWaveSpeed;

  @override
  State<PaperBadMenu> createState() => _PaperBadMenuState();
}

class _PaperBadMenuState extends State<PaperBadMenu>
    with SingleTickerProviderStateMixin {
  double editorOp = 1.0;
  List<Widget> desc = [];
  StreamController<bool> streamController = StreamController<bool>();
  late AnimationController animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 5));

  @override
  void dispose() {
    //streamController.close();
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.badgoodController.setIsBad(false);
      }
    });
    loadDesc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle h1 = Theme.of(context).textTheme.displayMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        );
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
              Center(
                child: Text(
                  'Write your negative thoughts on the paper below:',
                  style: h1,
                ),
              ),
              PaperBadInteractable(
                animationController: animationController,
                forMobile: (screenHeight > screenWidth),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 300.0, vertical: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    animationController.forward();
                    //widget.badgoodController.setIsBad(false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Burn',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ] +
            desc,
      ),
    );
  }

  void loadDesc() async {
    //print("yep");
    await rootBundle.loadString('pagebad.json').then((value) {
      setState(() {
        const double defHeight = 50;
        var serialized = jsonDecode(value);
        desc.add(Padding(
            padding: EdgeInsets.symmetric(
                vertical: ((widget.paragraphWaveHeight ?? defHeight) + 8))));
        //print(serialized);
        for (var paragraph in serialized) {
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

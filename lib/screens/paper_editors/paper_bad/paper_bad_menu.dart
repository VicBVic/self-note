import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:itec20222/screens/paper_editors/paper_bad/paperbad_interactable.dart';
import 'package:itec20222/screens/paper_editors/paper_bad/paperbad_utility.dart';
import 'package:itec20222/widgets/badgood_controller.dart';
import 'package:itec20222/widgets/expander_sliver.dart';
import 'package:itec20222/widgets/paragraph-provider.dart';
import 'package:itec20222/animations/animated_wavy_container.dart';

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
  ScrollController scrollController = ScrollController();
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

    return CustomScrollView(
      //shrinkWrap: true,
      controller: scrollController,
      slivers: <Widget>[
            SliverFillViewport(
              delegate: SliverChildListDelegate([
                PaperbadUtility(
                  animationController: animationController,
                  scrollController: scrollController,
                ),
              ]),
            )
          ] +
          desc,
    );
  }

  void loadDesc() async {
    //print("yep");
    int count = 0;
    await rootBundle.loadString('pagebad.json').then((value) {
      setState(() {
        var serialized = jsonDecode(value);
        for (var paragraph in serialized) {
          var argb = paragraph['Color'];
          count++;
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

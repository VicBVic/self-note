import 'package:flutter/material.dart';
import 'package:painter/painter.dart';

import '../paper.dart';

class PaperbadPaperstack extends StatelessWidget {
  final double paperHeight;
  final AnimationController animationController;
  const PaperbadPaperstack(
      {super.key,
      required this.paperHeight,
      required this.animationController});

  @override
  Widget build(BuildContext context) {
    return Stack(
      //fit: StackFit.expand,

      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: paperHeight,
          child: Image.asset(
            'assets/textures/dummy-no-royalty.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          child: BurnablePaper(
            animationController: animationController,
            anitmationDuration: const Duration(seconds: 5),
            color: Colors.black,
            pointCount: 50,
          ),
        ),
        SizedBox(
          height: paperHeight,
          child: Image.asset(
            'textures/paper_border.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

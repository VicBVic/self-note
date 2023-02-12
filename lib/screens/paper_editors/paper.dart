import 'dart:math';

import 'package:flutter/material.dart';
import 'package:itec20222/consts.dart';
import 'package:painter/painter.dart';

import '../../animations.dart/paper_burner.dart';

class BurnablePaper extends StatefulWidget {
  final int pointCount;
  final Color color;
  final Duration? anitmationDuration;
  final AnimationController animationController;
  final double paperHeight;
  BurnablePaper({
    Key? key,
    this.pointCount = 30,
    this.color = Colors.white,
    this.anitmationDuration,
    this.paperHeight = 750,
    required this.animationController,
  }) : super(key: key);

  @override
  State<BurnablePaper> createState() => _BurnablePaperState();
}

class _BurnablePaperState extends State<BurnablePaper>
    with SingleTickerProviderStateMixin {
  late Animation _animation;

  @override
  void initState() {
    //print(widget.burning);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: PaperBurner(
              CurvedAnimation(
                  parent: widget.animationController, curve: Curves.easeIn),
              pointsCount: widget.pointCount,
              color: widget.color,
            ),
          ),
        ),
      ],
    );
  }
}

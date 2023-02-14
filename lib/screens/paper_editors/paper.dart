import 'dart:math';

import 'package:flutter/material.dart';
import 'package:itec20222/consts.dart';
import 'package:painter/painter.dart';

import '../../animations/paper_burner.dart';
import '../../animations/zaggy_curve.dart';

class BurnablePaper extends StatefulWidget {
  static const int pointCount = 30;
  final Color color;
  final AnimationController animationController;
  BurnablePaper({
    Key? key,
    this.color = Colors.white,
    required this.animationController,
  }) : super(key: key);

  @override
  State<BurnablePaper> createState() => _BurnablePaperState();
}

class _BurnablePaperState extends State<BurnablePaper> {
  late List<Curve> pointCurves;

  @override
  void initState() {
    pointCurves = List.generate(BurnablePaper.pointCount,
        (ix) => ZaggyCurve(globalRng.nextInt(8).toDouble() + 5));
    widget.animationController.addListener(
      () => setState(() {}),
    );
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
        ClipPath(
          clipper: ClipperPaperBurn(pointCurves,
              animation: widget.animationController,
              pointCount: BurnablePaper.pointCount),
          child: Image.asset(
            'assets/textures/dummy-no-royalty.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}

class ClipperPaperBurn extends CustomClipper<Path> {
  final AnimationController animation;
  final int pointCount;
  final List<Curve> pointCurves;
  ClipperPaperBurn(this.pointCurves,
      {required this.pointCount, required this.animation})
      : super();

  @override
  Path getClip(Size size) {
    var pts = pointCurves
        .map((e) => e.transform(animation.value) * size.height)
        .toList();

    Path path = Path();
    //path.lineTo(size.width + 1, size.height);
    double variation = 0.1;
    for (int i = 0; i < pts.length; i++) {
      path.lineTo(size.width * (i / (pts.length - 1)) + 1,
          max(0, size.height - pts[i]));
    }
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:itec20222/animations/easer_curve.dart';
import 'package:itec20222/consts.dart';
import 'package:painter/painter.dart';

import '../../animations/paper_burner_UNUSED.dart';
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
  late List<Curve> backCurves;
  double op = 1;

  void animationListener() {
    setState(() {});
  }

  @override
  void initState() {
    backCurves = List.generate(
        BurnablePaper.pointCount,
        (ix) => ZaggyCurve(
              globalRng.nextInt(16).toDouble() + 1,
            ));
    pointCurves = backCurves.map((e) => EaseAnotherCurve(e)).toList();
    widget.animationController.addListener(animationListener);
    super.initState();
    //print(widget.burning);
  }

  @override
  void dispose() {
    widget.animationController.removeListener(animationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile =
        MediaQuery.of(context).size.width < MediaQuery.of(context).size.height;
    return AnimatedOpacity(
      duration: Duration(seconds: 3),
      opacity: op,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipPath(
            clipper: ClipperPaperBurn(
                pointCurves: backCurves,
                animation: CurvedAnimation(
                    parent: widget.animationController, curve: Curves.easeIn),
                pointCount: BurnablePaper.pointCount),
            child: Image.asset(
              'assets/textures/dummy-no-royalty.jpg',
              color: Colors.amber,
              fit: BoxFit.cover,
            ),
          ),
          ClipPath(
            clipper: ClipperPaperBurn(
                pointCurves: pointCurves,
                animation: CurvedAnimation(
                    parent: widget.animationController, curve: Curves.easeIn),
                pointCount: BurnablePaper.pointCount),
            child: Image.asset(
              'assets/textures/dummy-no-royalty.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Image.asset(
            'assets/textures/paper_border.png',
            fit: isMobile ? BoxFit.cover : BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

class ClipperPaperBurn extends CustomClipper<Path> {
  final Animation animation;
  final int pointCount;
  final List<Curve> pointCurves;
  ClipperPaperBurn(
      {required this.pointCurves,
      required this.pointCount,
      required this.animation})
      : super();

  @override
  Path getClip(Size size) {
    var pts = pointCurves
        .map((e) => (e.transform(animation.value)) * size.height)
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

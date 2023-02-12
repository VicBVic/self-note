import 'dart:math';

import 'package:flutter/material.dart';
import 'package:itec20222/animations.dart/random_curve.dart';

class PaperBurner extends CustomPainter {
  final Color color;
  final int pointsCount;
  final Animation animation;
  late final List<Curve> pointCurves;
  PaperBurner(this.animation,
      {required this.pointsCount, this.color = Colors.white, Key? key})
      : super() {
    pointCurves = List.generate(pointsCount, (ix) => RandomCurve(seed: ix));
  }

  @override
  paint(Canvas canvas, Size size) {
    if (animation.value == 0) return;
    //print("refreshed boi ${controller.value}");
    var pts = pointCurves
        .map((e) => e.transform(animation.value) * size.height)
        .toList();
    //print(pts);

    Path path = Path();
    Path outerPath = Path();
    double variation = 0.1;
    for (int i = 0; i < pts.length; i++) {
      path.lineTo(size.width * (i / (pts.length - 1)) + 1,
          max(0, size.height - pts[i]));
      outerPath.lineTo(size.width * (i / (pts.length - 1)),
          max(0, (size.height - pts[i] * (1 + variation))));
    }
    path.lineTo(size.width + 1, size.height);
    path.lineTo(0, size.height);
    outerPath.lineTo(size.width, size.height);
    outerPath.lineTo(0, size.height);

    Paint paint = Paint()..color = Colors.black;

    Paint outerPaint = Paint()..color = Colors.amber;

    //canvas.drawPath(outerPath, shadowPaint);
    canvas.drawPath(outerPath, outerPaint);
    canvas.drawPath(path, paint);

    RRect borderOut =
        RRect.fromLTRBR(0, 0, size.width, size.height, Radius.zero);
    double margin = 5.0;
    RRect borderIn = RRect.fromLTRBR(
        margin, margin, size.width - margin, size.height - margin, Radius.zero);

    canvas.drawDRRect(borderOut, borderIn, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

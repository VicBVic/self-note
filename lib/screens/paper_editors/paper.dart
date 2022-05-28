import 'dart:math';

import 'package:flutter/material.dart';
import 'package:itec20222/consts.dart';
import 'package:painter/painter.dart';

class Paper extends StatefulWidget {
  final int pointCount;
  final Color color;
  final Duration? anitmationDuration;
  final bool burning;
  Paper(
      {Key? key,
      this.pointCount = 30,
      this.color = Colors.white,
      this.anitmationDuration,
      this.burning = true})
      : super(key: key);

  @override
  State<Paper> createState() => _PaperState();
}

class _PaperState extends State<Paper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  List<double> points = [];

  @override
  void initState() {
    print(widget.burning);
    super.initState();
    // TODO: implement initState
    _controller =
        AnimationController(vsync: this, duration: widget.anitmationDuration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    for (int i = 0; i < widget.pointCount; i++) {
      points.add(0.0);
    }
    _controller.addListener(() {
      setState(() {
        for (int i = 0; i < points.length; i++) {
          points[i] =
              points[i] + Random().nextDouble() * 100 * _animation.value;
        }
      });
      //yprint(points);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.burning == true)
      _controller.forward();
    else
      _controller.animateTo(0.001);
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: PaperBurner(color: widget.color, pts: points),
          ),
        ),
      ],
    );
  }
}

class PaperBurner extends CustomPainter {
  final Color color;
  final List<double> pts;
  const PaperBurner({required this.pts, this.color = Colors.white, Key? key})
      : super();

  @override
  paint(Canvas canvas, Size size) {
    Path path = Path();
    Path outerPath = Path();
    double variation = 0.1;
    for (int i = 0; i < pts.length; i++) {
      path.lineTo(
          size.width * (i / (pts.length - 1)), max(0, size.height - pts[i]));
      outerPath.lineTo(size.width * (i / (pts.length - 1)),
          max(0, (size.height - pts[i] * (1 + variation))));
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    outerPath.lineTo(size.width, size.height);
    outerPath.lineTo(0, size.height);

    Paint paint = Paint()..color = color;

    Paint shadowPaint = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, 32)
      ..color = Color(0xff966400);

    Paint outerPaint = Paint()..color = Colors.amber;

    //canvas.drawPath(outerPath, shadowPaint);
    canvas.drawPath(outerPath, outerPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
    throw UnimplementedError();
  }
}

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:itec20222/animations/zaggy_curve.dart';
import 'package:itec20222/screens/paper_editors/burnable_paper.dart';

import '../consts.dart';

class AnimatedWavyContainer extends StatefulWidget {
  final Widget? child;
  final Color? color;
  final double waveLength;
  final double waveSpeed;
  final double waveHeight;
  const AnimatedWavyContainer({
    Key? key,
    this.child,
    this.color,
    this.waveLength = 400,
    this.waveSpeed = 0.5,
    this.waveHeight = 50,
  }) : super(key: key);

  @override
  State<AnimatedWavyContainer> createState() => _AnimatedWavyContainerState();
}

class _AnimatedWavyContainerState extends State<AnimatedWavyContainer>
    with SingleTickerProviderStateMixin {
  @override
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat();

  late List<Curve> pointCurves;
  late List<double> offsets;

  @override
  void initState() {
    pointCurves = List.generate(BurnablePaper.pointCount,
        (ix) => ZaggyCurve(globalRng.nextInt(3).toDouble() + 1));
    offsets = List.generate(
        BurnablePaper.pointCount, (index) => globalRng.nextDouble());
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final String imagePath = 'assets/textures/brown-papyrus-paper.jpg';

  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: widget.child,
      builder: (context, child) {
        return ClipPath(
          clipper: ClipperWave(
            pointCurves: pointCurves,
            pointCount: BurnablePaper.pointCount,
            height: widget.waveHeight,
            length: widget.waveLength,
            speed: widget.waveSpeed,
            waveAnimation: _animationController,
            offsets: offsets,
          ),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Container(color: widget.color),
              child ?? const Placeholder(),
            ],
          ),
        );
        //return child ?? Placeholder();
      },
    );
  }
}

class ClipperWave extends CustomClipper<Path> {
  final int pointCount;
  final List<Curve> pointCurves;
  final List<double> offsets;
  final Animation<double> waveAnimation;
  final double length;
  final double height;
  final double speed;
  final double variation = 0.1;
  ClipperWave({
    required this.offsets,
    required this.pointCount,
    required this.pointCurves,
    required this.waveAnimation,
    required this.length,
    required this.height,
    required this.speed,
  });
  @override
  Path getClip(Size size) {
    Path path = Path();

    double value = waveAnimation.value;

    //value = min(value, 1 - value) * 2;

    path.lineTo(size.width, 0);
    //path.lineTo(0, size.height);
    for (int i = pointCount - 1; i >= 0; i--) {
      double realValue = value;
      realValue += offsets[i];
      if (realValue > 1) realValue -= 1;
      realValue = min(realValue, 1 - realValue) * 2;
      path.lineTo(size.width * i / (pointCount - 1),
          pointCurves[i].transform(realValue) * height + size.height - height);
    }
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

// class WavePainter extends CustomPainter {
//   Animation<double> waveAnimation;
//   Color waveColor;
//   double positionPrecent;
//   double length;
//   double height;
//   double speed;

//   WavePainter(
//       {required this.waveAnimation,
//       required this.waveColor,
//       required this.positionPrecent,
//       required this.length,
//       required this.height,
//       required this.speed});

//   @override
//   void paint(Canvas canvas, Size size) {
//     //print("hree");
//     Path path = Path();
//     for (double i = 0.0;; i = min(size.width, i + length / 4)) {
//       path.lineTo(
//           i,
//           sin(((i * 2 * pi / length) +
//                       (waveAnimation.value * speed) * 2 * pi)) *
//                   height +
//               size.height * (1 - positionPrecent) +
//               height);
//       if (i == size.width) break;
//     }
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     Paint wavePaint = Paint()..color = waveColor;
//     canvas.drawPath(path, wavePaint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }

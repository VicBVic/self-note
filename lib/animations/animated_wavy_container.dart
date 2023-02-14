import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

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
    this.waveSpeed = 1,
    this.waveHeight = 50,
  }) : super(key: key);

  @override
  State<AnimatedWavyContainer> createState() => _AnimatedWavyContainerState();
}

class _AnimatedWavyContainerState extends State<AnimatedWavyContainer>
    with SingleTickerProviderStateMixin {
  @override
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: widget.child,
      builder: (context, child) {
        return ClipPath(
          clipper: ClipperWave(
            height: widget.waveHeight,
            length: widget.waveLength,
            speed: widget.waveSpeed,
            waveAnimation: _animationController,
          ),
          child: Container(color: widget.color, child: child),
        );
        //return child ?? Placeholder();
      },
    );
  }
}

class ClipperWave extends CustomClipper<Path> {
  final Animation<double> waveAnimation;
  final double length;
  final double height;
  final double speed;

  ClipperWave(
      {required this.waveAnimation,
      required this.length,
      required this.height,
      required this.speed});
  @override
  Path getClip(Size size) {
    Path path = Path();
    for (double i = 0.0;; i = min(size.width, i + length / 4)) {
      path.lineTo(
          i,
          sin(((i * 2 * pi / length) +
                      (waveAnimation.value * speed) * 2 * pi)) *
                  height +
              height);
      if (i == size.width) break;
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
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

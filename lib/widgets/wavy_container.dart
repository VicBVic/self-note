import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

class WavyContainer extends StatefulWidget {
  final Widget? child;
  final Color? color;
  final double width;
  final double height;
  final double? waveLength;
  final double? waveSpeed;
  final double? waveHeight;
  final double? waveProcent;
  const WavyContainer(
      {Key? key,
      this.child,
      this.color,
      required this.height,
      required this.width,
      this.waveLength,
      this.waveSpeed,
      this.waveHeight,
      this.waveProcent})
      : super(key: key);

  @override
  State<WavyContainer> createState() => _WavyContainerState();
}

class _WavyContainerState extends State<WavyContainer>
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
        return Stack(
          children: [
            SizedBox(
              height: widget.height,
              width: widget.width,
              //constraints:
              // BoxConstraints(minHeight: widget.height, minWidth: widget.width),
              child: CustomPaint(
                painter: WavePainter(
                    waveColor: widget.color ?? Colors.blue,
                    waveAnimation: _animationController,
                    height: widget.waveHeight ?? 20,
                    speed: widget.waveSpeed ?? 5,
                    length: widget.waveLength ?? 100,
                    positionPrecent: widget.waveProcent ?? 0.5),
                child: child,
              ),
            ),
          ],
        );
        //print("here");
        /*return Transform.rotate(
          angle: _animationController.value * 2.0 * pi,
          child: child,
        );*/
      },
    );
  }
}

class WavePainter extends CustomPainter {
  Animation<double> waveAnimation;
  Color waveColor;
  double positionPrecent;
  double length;
  double height;
  double speed;

  WavePainter(
      {required this.waveAnimation,
      required this.waveColor,
      required this.positionPrecent,
      required this.length,
      required this.height,
      required this.speed});

  @override
  void paint(Canvas canvas, Size size) {
    //print("hree");
    Path path = Path();
    for (double i = 0.0; i < size.width; i++) {
      path.lineTo(
          i,
          sin(((i * 2 * pi / length) +
                      (waveAnimation.value * speed) * 2 * pi)) *
                  height +
              size.height * (1 - positionPrecent));
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    Paint wavePaint = Paint()..color = waveColor;
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

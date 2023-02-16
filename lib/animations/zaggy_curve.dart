import 'dart:math';

import 'package:flutter/animation.dart';

import '../consts.dart';

class ZaggyCurve extends Curve {
  final double variation = 0.1;
  final double initalValue;
  final double frequency;

  const ZaggyCurve(this.frequency, [this.initalValue = 0]);

  double mainTransform(double t) {
    return t + sin(t);
  }

  @override
  double transform(double t) {
    return mainTransform(t * (frequency * (1) + t) * 2 * pi) /
        ((frequency * (1) + t) * 2 * pi);
  }
}

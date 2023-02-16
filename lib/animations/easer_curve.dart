import 'dart:math';

import 'package:flutter/material.dart';

class EaseAnotherCurve extends Curve {
  final Curve other;
  final double amount = 0.75;

  const EaseAnotherCurve(this.other);

  @override
  double transform(double t) {
    return min(1, other.transform(t) * 1 / amount);
  }
}

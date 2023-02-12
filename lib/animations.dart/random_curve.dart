import 'dart:math';

import 'package:flutter/animation.dart';

class RandomCurve extends Curve {
  final int seed;
  final double variation = 0.1;
  late Random rng;
  RandomCurve({required this.seed}) {
    rng = Random(seed);
  }

  double ahead = 0;

  @override
  double transform(double t) {
    double newAhead = min(2, t - variation + rng.nextDouble() * variation);
    ahead = max(ahead, newAhead);
    //print(ahead);
    return (ahead + t) / 2;
    //return super.transform(t);
  }
}

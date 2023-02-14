import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ParallaxSliverRenderer extends RenderSliverSingleBoxAdapter {
  ParallaxSliverRenderer({RenderBox? child}) : super(child: child);

  @override
  void performLayout() {
    //print("performing layout $constraints");
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    var boxConstraints = constraints.asBoxConstraints();
    boxConstraints = boxConstraints.copyWith(
      minHeight: constraints.viewportMainAxisExtent,
    );
    child?.layout(boxConstraints, parentUsesSize: true);

    double childExtent = child!.size.height;
    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: childExtent);
    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    // double origin =
    //     max(0, 2 * boxConstraints. - constraints.viewportMainAxisExtent) * -1;
    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: paintedChildSize,
      //cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      //hitTestExtent: paintedChildSize,
      //scrollOffsetCorrection: 50.0,
      //paintOrigin: -paintedChildSize,
      //layoutExtent: paintedChildSize,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );

    // boxConstraints = boxConstraints.copyWith(
    //   minHeight: constraints.viewportMainAxisExtent + paintedChildSize,
    // );

    setChildParentData(child!, constraints, geometry!);
  }
}

class ParallaxSliver extends SingleChildRenderObjectWidget {
  const ParallaxSliver({Widget? child, Key? key})
      : super(child: child, key: key);
  @override
  RenderObject createRenderObject(BuildContext context) {
    return ParallaxSliverRenderer();
  }
}

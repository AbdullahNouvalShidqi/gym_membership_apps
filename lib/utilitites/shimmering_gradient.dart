import 'package:flutter/material.dart';

class SlidingGradientTransform extends GradientTransform {
  const SlidingGradientTransform({
    required this.slidePercent,
    required this.context
  });

  final double slidePercent;
  final BuildContext context;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(MediaQuery.of(context).size.width * slidePercent, 0.0, 0.0);
  }
}
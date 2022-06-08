import 'package:flutter/material.dart';
import 'package:gym_membership_apps/utilitites/shimmering_gradient.dart';

class Shimmer extends StatefulWidget{
  static ShimmerState? of(BuildContext context){
    return context.findAncestorStateOfType<ShimmerState>();
  }

  const Shimmer({
    super.key,
    required this.linearGradient,
    this.child
  });

  final LinearGradient linearGradient;
  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.0, period: const Duration(milliseconds: 1000));


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Gradient get gradient => LinearGradient(
        colors: widget.linearGradient.colors,
        stops: widget.linearGradient.stops,
        begin: widget.linearGradient.begin,
        end: widget.linearGradient.end,
        transform: SlidingGradientTransform(context: context, slidePercent: _animationController.value)
      );

  AnimationController get shimmerChanges => _animationController;

  bool get isSized => (context.findRenderObject() as RenderBox).hasSize;

  Size get size => (context.findRenderObject() as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

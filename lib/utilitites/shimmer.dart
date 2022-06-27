import 'package:flutter/material.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class Shimmer extends StatefulWidget {
  const Shimmer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController.unbounded(vsync: this)
    ..repeat(
      min: -1.0,
      max: 1.0,
      period: const Duration(milliseconds: 1000),
    );

  @override
  void initState() {
    _animationController.addListener(updateAnimation);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void updateAnimation() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return Utilities.gradient(value: _animationController.value).createShader(bounds);
      },
      child: widget.child,
    );
  }
}

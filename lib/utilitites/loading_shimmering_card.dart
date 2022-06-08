import 'package:flutter/material.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class ShimmeringCard extends StatefulWidget {
  const ShimmeringCard({
    Key? key, 
    required this.height, 
    required this.width, 
    this.margin, 
    this.child,
    this.borderRadius,
    this.boxShape,
    this.gradientColors,
    this.gradientBegin,
    this.gradientEnd
  }) : super(key: key);
  final double height;
  final double width;
  final EdgeInsets? margin;
  final Widget? child;
  final BorderRadius? borderRadius;
  final BoxShape? boxShape;
  final List<Color>? gradientColors;
  final Alignment? gradientBegin;
  final Alignment? gradientEnd;

  @override
  State<ShimmeringCard> createState() => _ShimmeringCardState();
}

class _ShimmeringCardState extends State<ShimmeringCard> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.0, period: const Duration(milliseconds: 1000));
  double value = 0;
  bool disposed = false;

  @override
  void initState() {
    _animationController.addListener(changeValue);
    super.initState();
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void changeValue(){
    setState(() {
      value = _animationController.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        boxShadow: const [
          BoxShadow(blurRadius: 8, color: Color.fromARGB(255, 230, 230, 230))
        ],
        shape: widget.boxShape ?? BoxShape.rectangle,
        gradient: Utilities.gradient(
          context: context,
          value: value,
          colors: widget.gradientColors,
          begin: widget.gradientBegin,
          end: widget.gradientEnd
        ),
      ),
      child: widget.child,
    );
  }
}
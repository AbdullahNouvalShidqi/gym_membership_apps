import 'package:flutter/material.dart';

class ShimmerContainer extends StatefulWidget {
  const ShimmerContainer({
    Key? key,
    required this.height,
    required this.width,
    this.margin,
    this.child,
    this.borderRadius,
    this.boxShape,
    this.useBoxShadow = false,
  }) : super(key: key);
  final double height;
  final double width;
  final EdgeInsets? margin;
  final Widget? child;
  final BorderRadius? borderRadius;
  final BoxShape? boxShape;
  final bool useBoxShadow;

  @override
  State<ShimmerContainer> createState() => _ShimmerContainerState();
}

class _ShimmerContainerState extends State<ShimmerContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        color: Colors.black,
        boxShadow: widget.useBoxShadow
            ? const [
                BoxShadow(blurRadius: 8, color: Color.fromARGB(255, 230, 230, 230)),
              ]
            : null,
        shape: widget.boxShape ?? BoxShape.rectangle,
      ),
      child: widget.child,
    );
  }
}

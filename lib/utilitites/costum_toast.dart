import 'package:flutter/material.dart';

class CostumToast extends StatelessWidget {
  const CostumToast({
    Key? key,
    required this.msg,
    this.height,
    this.width,
    this.borderRadius,
    this.childPadding,
    this.textPadding,
    this.backgroundColor,
    this.textColor
  }) : super(key: key);
  final String msg;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? childPadding;
  final EdgeInsetsGeometry? textPadding;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        color: backgroundColor ?? Colors.black
      ),
      child: Center(
        child: 
          Text(msg, textAlign: TextAlign.center, softWrap: true, style: TextStyle(color: textColor ?? Colors.white),
        )
      ),
    );
  }
}
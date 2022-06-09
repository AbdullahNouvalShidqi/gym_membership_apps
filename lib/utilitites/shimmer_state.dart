import 'package:flutter/material.dart';
import 'package:gym_membership_apps/utilitites/shimmer.dart';

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({Key? key, required this.isLoading, this.loadingChild, required this.child}) : super(key: key);
  final bool isLoading;
  final Widget? loadingChild;
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  @override
  Widget build(BuildContext context) {
    if(!widget.isLoading){
      return widget.child;
    }
    if(widget.loadingChild != null){
      return Scaffold(
        body: Shimmer(
          child: widget.loadingChild!
        ),
      );
    }
    return Shimmer(
      child: widget.child
    );
  }
}
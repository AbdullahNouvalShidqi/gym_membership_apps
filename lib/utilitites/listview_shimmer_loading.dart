import 'package:flutter/material.dart';
import 'package:gym_membership_apps/utilitites/shimmer.dart';

import 'shimmer_container.dart';

class ListViewShimmerLoading extends StatelessWidget {
  const ListViewShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        itemCount: 8,
        itemBuilder: (context, i){
          return ShimmerContainer(
            height: 114,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            borderRadius: BorderRadius.circular(8),
          );
        }
      ),
    );
  }
}
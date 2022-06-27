import 'package:flutter/material.dart';
import 'package:gym_membership_apps/utilitites/shimmer.dart';

import 'shimmer_container.dart';

enum ShimmeringLoadingFor { scheduleScreen, availableScreen }

class ListViewShimmerLoading extends StatelessWidget {
  const ListViewShimmerLoading({Key? key, required this.shimmeringLoadingFor, this.controller}) : super(key: key);
  final ShimmeringLoadingFor shimmeringLoadingFor;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Column(
        children: [
          const SizedBox(height: 5),
          if (shimmeringLoadingFor == ShimmeringLoadingFor.scheduleScreen) ...[
            Row(
              children: [
                for (var i = 0; i < 4; i++) ...[
                  if (i == 0) ...[
                    const SizedBox(width: 20),
                    ShimmerContainer(height: 35, width: 43, borderRadius: BorderRadius.circular(15)),
                    const SizedBox(width: 5),
                  ] else ...[
                    ShimmerContainer(height: 35, width: 62, borderRadius: BorderRadius.circular(15)),
                    const SizedBox(width: 5),
                  ]
                ]
              ],
            ),
          ] else ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ShimmerContainer(height: 63, width: double.infinity, borderRadius: BorderRadius.circular(10)),
            )
          ],
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 15),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8,
              itemBuilder: (context, i) {
                return ShimmerContainer(
                  height: 114,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  borderRadius: BorderRadius.circular(8),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

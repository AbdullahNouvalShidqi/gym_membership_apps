import 'package:flutter/material.dart';
import 'package:gym_membership_apps/utilitites/shimmer_container.dart';
import 'package:gym_membership_apps/utilitites/shimmer.dart';

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Padding(
        padding: const EdgeInsets.only(top: 57),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    const ShimmerContainer(height: 48, width: 48, boxShape: BoxShape.circle),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerContainer(height: 14, width: 165, borderRadius: BorderRadius.circular(20)),
                        const SizedBox(height: 5),
                        ShimmerContainer(height: 14, width: 165, borderRadius: BorderRadius.circular(20)),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    ShimmerContainer(height: 28, width: 122, borderRadius: BorderRadius.circular(20)),
                    const SizedBox(height: 12),
                    ShimmerContainer(height: 28, width: 122, borderRadius: BorderRadius.circular(20)),
                    const SizedBox(height: 33),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerContainer(height: 14, width: 91, borderRadius: BorderRadius.circular(20)),
                        ShimmerContainer(height: 14, width: 49, borderRadius: BorderRadius.circular(20)),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              SizedBox(
                height: 164,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, i) {
                    return ShimmerContainer(
                      height: 164,
                      width: 125,
                      borderRadius: BorderRadius.circular(8),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerContainer(height: 14, width: 91, borderRadius: BorderRadius.circular(20)),
                    ShimmerContainer(height: 14, width: 49, borderRadius: BorderRadius.circular(20)),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 164,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, i) {
                    return ShimmerContainer(
                      height: 164,
                      width: 125,
                      borderRadius: BorderRadius.circular(8),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ShimmerContainer(height: 14, width: 88, borderRadius: BorderRadius.circular(20)),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 129,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, i) {
                    return ShimmerContainer(
                      height: 129,
                      width: 210,
                      borderRadius: BorderRadius.circular(8),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

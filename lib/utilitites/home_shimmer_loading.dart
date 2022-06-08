import 'package:flutter/material.dart';
import 'package:gym_membership_apps/utilitites/loading_shimmering_card.dart';

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 57, left: 20, right: 20),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const ShimmeringCard(
                  height: 48,
                  width: 48,
                  boxShape: BoxShape.circle,
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmeringCard(
                      height: 14,
                      width: 165,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    const SizedBox(height: 5,),
                    ShimmeringCard(
                      height: 14,
                      width: 165,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30,),
            ShimmeringCard(
              height: 28,
              width: 122,
              borderRadius: BorderRadius.circular(20),
            ),
            const SizedBox(height: 12,),
            ShimmeringCard(
              height: 28,
              width: 122,
              borderRadius: BorderRadius.circular(20),
            ),
            const SizedBox(height: 33,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmeringCard(
                  height: 14,
                  width: 91,
                  borderRadius: BorderRadius.circular(20),
                ),
                ShimmeringCard(
                  height: 14,
                  width: 49,
                  borderRadius: BorderRadius.circular(20),
                ),
              ],
            ),
            const SizedBox(height: 15,),
            SizedBox(
              height: 164,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, i){
                  return ShimmeringCard(
                    height: 164,
                    width: 125,
                    borderRadius: BorderRadius.circular(8),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                  );
                }
              ),
            ),
            const SizedBox(height: 18,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmeringCard(
                  height: 14,
                  width: 91,
                  borderRadius: BorderRadius.circular(20),
                ),
                ShimmeringCard(
                  height: 14,
                  width: 49,
                  borderRadius: BorderRadius.circular(20),
                ),
              ],
            ),
            const SizedBox(height: 15,),
            SizedBox(
              height: 164,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, i){
                  return ShimmeringCard(
                    height: 164,
                    width: 125,
                    borderRadius: BorderRadius.circular(8),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                  );
                }
              ),
            ),
            const SizedBox(height: 20,),
            ShimmeringCard(
              height: 14,
              width: 88,
              borderRadius: BorderRadius.circular(20),
            ),
            const SizedBox(height: 15,),
            ShimmeringCard(
              height: 164,
              width: double.infinity,
              borderRadius: BorderRadius.circular(20),
            ),
          ],
        ),
      ),
    );
  }
}
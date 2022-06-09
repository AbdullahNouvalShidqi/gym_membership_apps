import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_membership_apps/utilitites/shimmer_container.dart';

class DetailShimmerLoading extends StatelessWidget {
  const DetailShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerContainer(
            height: 315,
            width: double.infinity
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerContainer(
                        height: 17.5,
                        width: 111,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      ShimmerContainer(
                        height: 10.5,
                        width: 35,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  ShimmerContainer(
                    height: 14,
                    width: 88,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/gym_loading.svg'),
                      const SizedBox(width: 5,),
                      ShimmerContainer(
                        height: 8.75,
                        width: 43,
                        borderRadius: BorderRadius.circular(12.5),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.25,),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/location_loading.svg'),
                      const SizedBox(width: 5,),
                      ShimmerContainer(
                        height: 8.75,
                        width: 89,
                        borderRadius: BorderRadius.circular(12.5),
                      ),
                    ],
                  ),
                  const SizedBox(height: 13.25,),
                  ShimmerContainer(
                    height: 12.25,
                    width: 107,
                    borderRadius: BorderRadius.circular(17.5),
                  ),
                  const SizedBox(height: 8.75,),
                  ShimmerContainer(
                    height: 10.5,
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(17.5),
                  ),
                  const SizedBox(height: 4.5,),
                  Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 7,
                      itemBuilder: (context, i){
                        return ShimmerContainer(
                          height: 10.5,
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(17.5),
                          margin: const EdgeInsets.only(bottom: 4.5),
                        );
                      }
                    ),
                  ),
          
                ],
              ),
            ),
          ),
          Center(
            child: ShimmerContainer(
              height: 14,
              width: 140,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 45,)
        ],
      ),
    );
  }
}
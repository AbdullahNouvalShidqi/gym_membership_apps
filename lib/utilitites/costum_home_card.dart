import 'package:flutter/material.dart';
import 'package:gym_membership_apps/model/home_class_model.dart';
import 'package:gym_membership_apps/screen/detail/detail_screen.dart';
import 'package:gym_membership_apps/screen/see_all/see_all_screen.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class CostumHomeCard extends StatelessWidget {
  const CostumHomeCard({
    Key? key,
    required this.homeClassModel,
    required this.type,
    required this.height,
    required this.width,
  }) : super(key: key);
  final List<HomeClassModel> homeClassModel;
  final String type;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$type Class', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, SeeAllScren.routeName, arguments: type);
                },
                child: const Text(
                  'See All',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Utilities.primaryColor),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: height,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: homeClassModel.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailScreen.routeName,
                      arguments: {'homeClassModel': homeClassModel[i], 'type': type},
                    );
                  },
                  child: Container(
                    width: width,
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(image: AssetImage(homeClassModel[i].images.first), fit: BoxFit.cover),
                    ),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                          colors: [Colors.black, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              homeClassModel[i].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                            const Text(
                              'Class',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

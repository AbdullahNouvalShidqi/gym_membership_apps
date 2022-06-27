import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_grid_view.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class SeeAllScren extends StatefulWidget {
  static String routeName = '/seeAll';
  const SeeAllScren({Key? key}) : super(key: key);

  @override
  State<SeeAllScren> createState() => _SeeAllScrenState();
}

class _SeeAllScrenState extends State<SeeAllScren> {
  String type = '';

  @override
  Widget build(BuildContext context) {
    type = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: Consumer<ProfileViewModel>(
        builder: (context, profileViewModel, _) {
          final user = profileViewModel.user;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 57, left: 20, right: 20),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Utilities.primaryColor,
                        radius: 25,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Hello,', style: Utilities.greetingHomeStyle),
                          Text(user.username, style: Utilities.greetinSubHomeStyle),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 12, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Select', style: Utilities.homeViewMainTitleStyle),
                      Text('$type Class', style: Utilities.homeViewMainTitleStyle),
                    ],
                  ),
                ),
                CostumGridView(type: type)
              ],
            ),
          );
        },
      ),
    );
  }
}

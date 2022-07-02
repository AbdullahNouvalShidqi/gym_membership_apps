import 'package:flutter/material.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

import 'components.dart';

class BookScreen extends StatelessWidget {
  static String routeName = '/book';
  const BookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileViewModel>(context).user;
    final item = ModalRoute.of(context)!.settings.arguments as ClassModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Class', style: Utilities.appBarTextStyle),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  BookingDetail(item: item),
                  const SizedBox(height: 20),
                  UserInformation(user: user),
                ],
              ),
            ),
          ),
          CostumButtons(item: item)
        ],
      ),
    );
  }
}

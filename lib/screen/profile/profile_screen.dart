import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:provider/provider.dart';

import 'components.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profileScreen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Provider.of<ProfileViewModel>(context, listen: false).initListController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.watch<ProfileViewModel>();
    return Scaffold(
      body: SingleChildScrollView(
        controller: profileViewModel.singleListController,
        physics: const NeverScrollableScrollPhysics(),
        child: Center(
          child: Column(
            children: const [
              MainProfile(),
              SizedBox(height: 30),
              TabButton(),
              SizedBox(height: 15),
              ItemToReturn(),
            ],
          ),
        ),
      ),
    );
  }
}

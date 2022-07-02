import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/profile_update_password/profile_update_password_view_model.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

import 'components.dart';

class ProfileUpdatePasswordScreen extends StatefulWidget {
  static String routeName = '/profileUpdatePassword';
  const ProfileUpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ProfileUpdatePasswordScreen> createState() => _ProfileUpdatePasswordScreenState();
}

class _ProfileUpdatePasswordScreenState extends State<ProfileUpdatePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final profileUpdatePasswordViewModel = context.watch<ProfileUpdatePasswordViewModel>();
    return WillPopScope(
      onWillPop: () async {
        return await profileUpdatePasswordViewModel.onWillPop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Password', style: Utilities.appBarTextStyle),
          leading: IconButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              if (await profileUpdatePasswordViewModel.onWillPop(context)) {
                navigator.pop();
              }
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Form(
            key: profileUpdatePasswordViewModel.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CurrentPasswordFormField(),
                  SizedBox(height: 20),
                  NewPasswordFormField(),
                  SizedBox(height: 20),
                  ConfirmFormField(),
                  SizedBox(height: 15),
                  ContinueButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

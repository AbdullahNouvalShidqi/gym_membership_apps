import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/update_password/update_password_view_model.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

import 'components.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static String routeName = '/updatePassword';
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final updatePasswordViewModel = context.watch<UpdatePasswordViewModel>();
    return WillPopScope(
      onWillPop: () async {
        return await updatePasswordViewModel.onWillPop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Update Password',
            style: Utilities.appBarTextStyle,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: updatePasswordViewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 40),
                  NewPasswordFormField(),
                  SizedBox(height: 20),
                  ConfirmFormField(),
                  SizedBox(height: 30),
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

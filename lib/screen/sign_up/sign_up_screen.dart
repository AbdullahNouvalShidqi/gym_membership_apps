import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/sign_up/sign_up_view_model.dart';
import 'package:provider/provider.dart';

import 'components.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = '/signUpScreen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final signUpViewModel = context.watch<SignUpViewModel>();

    return Form(
      onWillPop: () async {
        return await signUpViewModel.willPopValidation(context);
      },
      key: signUpViewModel.formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                MainTitle(),
                UsernameFormField(),
                EmailFormField(),
                PhoneNumberFormField(),
                PasswordFormField(),
                ConfirmFormField(),
                RememberMeCheckBox(),
                SignUpButton(),
                ToSignInButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

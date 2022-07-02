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
              children: [
                const MainTitle(),
                const UsernameFormField(),
                const EmailFormField(),
                const PhoneNumberFormField(),
                const PasswordFormField(),
                const ConfirmFormField(),
                const RememberMeCheckBox(),
                const SignUpButton(),
                Center(
                  child: Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                googleSiugnUpButton(),
                const ToSignInButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget googleSiugnUpButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 45)),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/google_logo.png',
                width: 25,
              ),
              const SizedBox(width: 10),
              const Text(
                'Sign up with Google',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}

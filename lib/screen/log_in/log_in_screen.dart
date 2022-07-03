import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/log_in/log_in_view_model.dart';
import 'package:provider/provider.dart';

import 'components.dart';

class LogInScreen extends StatefulWidget {
  static String routeName = '/logInScreen';
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  void initState() {
    Provider.of<LogInViewModel>(context, listen: false).setEmailAndPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.watch<LogInViewModel>();
    return WillPopScope(
      onWillPop: () async {
        return await loginViewModel.willPopValidation(context);
      },
      child: Form(
        key: loginViewModel.formKey,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MainTitle(),
                  const EmailFormField(),
                  const SizedBox(height: 10),
                  const PasswordFormField(),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      RememberMeCheckBox(),
                      ForgotPassword(),
                    ],
                  ),
                  const LoginButton(),
                  const ToSignUpButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

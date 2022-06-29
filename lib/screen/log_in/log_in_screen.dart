import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/forgot_password/forgot_password_screen.dart';
import 'package:gym_membership_apps/screen/log_in/log_in_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_button.dart';
import 'package:gym_membership_apps/utilitites/costum_form_field.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

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
      onWillPop: loginViewModel.willPopValidation(context),
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
                  Center(
                    child: Text(
                      'OR',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey[700]),
                    ),
                  ),
                  googleLoginButton(),
                  const ToSignUpButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget googleLoginButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
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
                'Sign in with Google',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LogInViewModel>(
      builder: (context, loginViewModel, _) {
        return CostumFormField(
          controller: loginViewModel.passwordCtrl,
          label: 'Password',
          hintText: 'Enter your password',
          prefixIcon: const Icon(Icons.lock_outline),
          textInputType: TextInputType.visiblePassword,
          validator: (newValue) {
            if (newValue == null || newValue.isEmpty || newValue == ' ') {
              return 'Please enter your password';
            } else if (newValue.contains('  ')) {
              return 'Your password contains double space, please remove it';
            } else if (newValue.length < 6) {
              return 'The minimal length of password is 6';
            } else if (!Utilities.pwNeedOneCapital.hasMatch(newValue)) {
              return 'Please enter at least one alphabet letter in your password';
            } else if (!Utilities.pwNeedOneNonCapital.hasMatch(newValue)) {
              return 'Please enter at least one non alphabet letter in your password';
            } else if (!Utilities.pwNeedOneNumber.hasMatch(newValue)) {
              return 'Please enter at least one number in your password';
            }
            return null;
          },
          useIconHidePassword: true,
        );
      },
    );
  }
}

class MainTitle extends StatelessWidget {
  const MainTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, bottom: 50),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Hello! Welcome back!', style: Utilities.signInSignUpMainTitleStyle),
            SizedBox(height: 4),
            Text("Hello again, You've been missed!", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}

class EmailFormField extends StatelessWidget {
  const EmailFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LogInViewModel>(builder: (context, logInViewModel, _) {
      return CostumFormField(
        controller: logInViewModel.emailCtrl,
        label: 'Email Address',
        hintText: 'Enter your email address',
        prefixIcon: const Icon(Icons.email_outlined),
        textInputType: TextInputType.emailAddress,
        validator: (newValue) {
          if (newValue == null || newValue.isEmpty || newValue == ' ') {
            return 'Please enter your email address';
          } else if (!Utilities.emailRegExp.hasMatch(newValue) || newValue.contains('  ')) {
            return 'Please enter a valid email address';
          }
          return null;
        },
      );
    });
  }
}

class RememberMeCheckBox extends StatelessWidget {
  const RememberMeCheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logInViewModel = context.watch<LogInViewModel>();
    return Row(
      children: [
        Transform.scale(
          scale: 1.2,
          child: SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: logInViewModel.rememberMe,
              onChanged: logInViewModel.rememberMeCheckBoxOnTap,
            ),
          ),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: logInViewModel.rememberMeLabelOnTap,
          child: const Text('Remember Me', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
      },
      child: const Text('Forgot Password', style: TextStyle(fontSize: 12, color: Colors.red)),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LogInViewModel>(
      builder: (context, logInViewModel, _) {
        final isLoading = logInViewModel.state == LogInState.loading;

        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 25),
            child: CostumButton(
              height: 45,
              isLoading: isLoading,
              childText: 'Login',
              onPressed: logInViewModel.loginButtonOnTap(context),
            ),
          ),
        );
      },
    );
  }
}

class ToSignUpButton extends StatelessWidget {
  const ToSignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logInViewModel = context.watch<LogInViewModel>();
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Center(
        child: RichText(
          text: TextSpan(
            text: "Don't have an account? ",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            children: [
              TextSpan(
                text: 'Sign Up',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Utilities.primaryColor),
                recognizer: TapGestureRecognizer()..onTap = logInViewModel.signUpButtonOnTap(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}

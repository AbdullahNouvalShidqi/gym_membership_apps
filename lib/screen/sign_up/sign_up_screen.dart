import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/sign_up/sign_up_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_button.dart';
import 'package:gym_membership_apps/utilitites/costum_form_field.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

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
      onWillPop: signUpViewModel.willPopValidation(context),
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

class MainTitle extends StatelessWidget {
  const MainTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, bottom: 40),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Create an account', style: Utilities.signInSignUpMainTitleStyle),
            SizedBox(height: 4),
            Text("Stay strong and healthy with us", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}

class UsernameFormField extends StatelessWidget {
  const UsernameFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpViewModel = context.watch<SignUpViewModel>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CostumFormField(
        controller: signUpViewModel.usernameCtrl,
        label: 'Username',
        hintText: 'Enter your username',
        prefixIcon: const Icon(CupertinoIcons.person_crop_circle),
        validator: (newValue) {
          if (newValue == null || newValue.isEmpty || newValue == ' ') {
            return 'Please enter a username';
          } else if (newValue.contains(' ')) {
            return 'Please enter a valid username(no spaces)';
          } else if (signUpViewModel.allUser.any((element) => element.username == newValue)) {
            return 'Username already used by other user';
          }
          return null;
        },
      ),
    );
  }
}

class EmailFormField extends StatelessWidget {
  const EmailFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpViewModel = context.watch<SignUpViewModel>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CostumFormField(
        controller: signUpViewModel.emailCtrl,
        label: 'Email Address',
        hintText: 'Enter your email address',
        prefixIcon: const Icon(Icons.email_outlined),
        textInputType: TextInputType.emailAddress,
        validator: (newValue) {
          if (newValue == null || newValue.isEmpty || newValue == ' ') {
            return 'Please enter your email address';
          } else if (newValue.contains('  ') || !Utilities.emailRegExp.hasMatch(newValue)) {
            return 'Please enter a valid email address';
          } else if (signUpViewModel.allUser.any((element) => element.email == newValue)) {
            return 'Email address is already used by other user';
          }
          return null;
        },
      ),
    );
  }
}

class PhoneNumberFormField extends StatelessWidget {
  const PhoneNumberFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpViewModel = context.watch<SignUpViewModel>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CostumFormField(
        controller: signUpViewModel.phoneNumberCtrl,
        label: 'Phone Number',
        hintText: 'Enter your phone number',
        prefixIcon: const Icon(Icons.phone_outlined),
        textInputType: TextInputType.phone,
        validator: (newValue) {
          if (newValue == null || newValue.isEmpty || newValue == ' ') {
            return 'Please enter your phone number';
          } else if (newValue.contains('  ') ||
              int.tryParse(newValue) == null ||
              newValue.length < 11 ||
              newValue.length > 13) {
            return 'Please enter a valid phone number';
          }
          return null;
        },
      ),
    );
  }
}

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpViewModel = context.watch<SignUpViewModel>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CostumFormField(
        controller: signUpViewModel.passwordCtrl,
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
            return 'Please enter at least one capital letter in your password';
          } else if (!Utilities.pwNeedOneNonCapital.hasMatch(newValue)) {
            return 'Please enter at least one non capital letter in your password';
          } else if (!Utilities.pwNeedOneNumber.hasMatch(newValue)) {
            return 'Please enter at least one number in your password';
          }
          return null;
        },
        useIconHidePassword: true,
      ),
    );
  }
}

class ConfirmFormField extends StatelessWidget {
  const ConfirmFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpViewModel = context.watch<SignUpViewModel>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: CostumFormField(
        controller: signUpViewModel.confirmPasswordCtrl,
        label: 'Confirm Password',
        hintText: 'Enter your password',
        prefixIcon: const Icon(Icons.lock_outline),
        textInputType: TextInputType.visiblePassword,
        validator: (newValue) {
          if (newValue == null || newValue.isEmpty || newValue == ' ') {
            return 'Please enter your password';
          } else if (newValue.contains('  ')) {
            return 'Please enter a valid password';
          } else if (newValue != signUpViewModel.passwordCtrl.text) {
            return 'Please enter a same password';
          }
          return null;
        },
        useIconHidePassword: true,
      ),
    );
  }
}

class RememberMeCheckBox extends StatelessWidget {
  const RememberMeCheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpViewModel = context.watch<SignUpViewModel>();
    return Row(
      children: [
        Transform.scale(
          scale: 1.2,
          child: SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: signUpViewModel.rememberMe,
              onChanged: signUpViewModel.rememberMeCheckBoxOnTap,
            ),
          ),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: signUpViewModel.rememberMeLabelOnTap,
          child: const Text(
            'Remember Me',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(
      builder: (context, signUpViewModel, _) {
        final isLoading = signUpViewModel.state == SignUpState.loading;
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 15),
            child: CostumButton(
              height: 45,
              onPressed: signUpViewModel.signUpButtonOnPressed(context),
              isLoading: isLoading,
              childText: 'Sign Up',
            ),
          ),
        );
      },
    );
  }
}

class ToSignInButton extends StatelessWidget {
  const ToSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpViewModel = context.watch<SignUpViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: RichText(
          text: TextSpan(
            text: 'Already have an account? ',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            children: [
              TextSpan(
                text: 'Log in',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Utilities.primaryColor),
                recognizer: TapGestureRecognizer()..onTap = signUpViewModel.toLoginOnTap(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

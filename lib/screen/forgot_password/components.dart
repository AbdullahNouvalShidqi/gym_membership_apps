import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/screen/forgot_password/forgot_password_view_model.dart';
import 'package:gym_membership_apps/screen/otp/otp_screen.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_button.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_form_field.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class MainLogo extends StatelessWidget {
  const MainLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 130, bottom: 45),
        child: SvgPicture.asset('assets/icons/fw_logo.svg'),
      ),
    );
  }
}

class MainTitle extends StatelessWidget {
  const MainTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 120,
          child: Text('Forgot Password?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
        ),
        const SizedBox(height: 15),
        Text(
          "Don't worry ! It happens. Please enter the email we will send the OTP in this email.",
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }
}

class EmailFormField extends StatelessWidget {
  const EmailFormField({Key? key, required this.emailCtrl}) : super(key: key);
  final TextEditingController emailCtrl;

  @override
  Widget build(BuildContext context) {
    return CostumFormField(
      controller: emailCtrl,
      label: 'Email Address',
      hintText: 'Enter your email',
      prefixIcon: const Icon(Icons.email_outlined),
      textInputType: TextInputType.emailAddress,
      validator: (newValue) {
        if (newValue == null || newValue == '') {
          return 'Please enter your email';
        }
        if (newValue.contains(' ') || !Utilities.emailRegExp.hasMatch(emailCtrl.text)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key, required this.formKey, required this.emailCtrl}) : super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordViewModel>(
      builder: (context, forgotPasswordViewModel, _) {
        final isLoading = forgotPasswordViewModel.state == ForgotPasswordState.loading;
        return CostumButton(
          isLoading: isLoading,
          onPressed: () async {
            final navigator = Navigator.of(context);
            final focusScope = FocusScope.of(context);

            if (!formKey.currentState!.validate()) return;
            focusScope.unfocus();
            await forgotPasswordViewModel.getAllUser();
            final allUser = forgotPasswordViewModel.allUser;
            final email = emailCtrl.text.toLowerCase();
            bool isError = forgotPasswordViewModel.state == ForgotPasswordState.error;

            if (isError) {
              Fluttertoast.showToast(msg: 'Something went wrong, try again.');
              return;
            }

            final user = allUser.where((element) => element.email.toLowerCase() == email.toLowerCase()).toList();

            if (user.length > 1 || user.isEmpty) {
              Fluttertoast.showToast(
                msg: 'No user with email of $email found on our database, sign up first or check your email',
              );
              focusScope.requestFocus();
              return;
            }

            final id = user.first.id;
            await forgotPasswordViewModel.sendOTP(email: email);

            isError = forgotPasswordViewModel.state == ForgotPasswordState.error;
            if (isError) {
              Fluttertoast.showToast(msg: 'Error, we cannot send your otp, check your email or your internet');
              return;
            }
            navigator.pushReplacementNamed(OtpScreen.routeName, arguments: id);
          },
          childText: 'Continue',
        );
      },
    );
  }
}

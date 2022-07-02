import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/screen/forgot_password/forgot_password_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_button.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 95),
          child: SvgPicture.asset('assets/icons/otp_logo.svg'),
        ),
        const SizedBox(height: 35),
        const Text('OTP VERIFICATION', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        const SizedBox(height: 15),
        Text(
          'Enter the OTP sent to ${ForgotPasswordViewModel.encryptedEmail}',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}

class CostumPinCodeTextField extends StatelessWidget {
  const CostumPinCodeTextField({
    Key? key,
    required this.otpController,
    required this.hasError,
    required this.onChanged,
  }) : super(key: key);
  final TextEditingController otpController;
  final bool hasError;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      showCursor: true,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      mainAxisAlignment: MainAxisAlignment.center,
      controller: otpController,
      appContext: context,
      length: 4,
      onChanged: onChanged,
      pinTheme: Utilities.myPinTheme(hasError: hasError),
    );
  }
}

class ResendOTP extends StatelessWidget {
  const ResendOTP({Key? key, required this.resetTime}) : super(key: key);
  final void Function() resetTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't receive code ?", style: TextStyle(fontSize: 16)),
        const SizedBox(width: 5),
        Consumer<ForgotPasswordViewModel>(
          builder: (context, forgotPasswordViewModel, _) {
            return InkWell(
              onTap: () async {
                Fluttertoast.showToast(msg: 'Sending OTP');
                await forgotPasswordViewModel.resendOTP();
                final isError = forgotPasswordViewModel.state == ForgotPasswordState.error;

                if (isError) {
                  Fluttertoast.cancel();
                  Fluttertoast.showToast(msg: 'We cannot re-send otp to your email, try again');
                  return;
                }
                resetTime();
              },
              child: const Text('Re-send', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            );
          },
        )
      ],
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key, required this.hasError, required this.onPressed}) : super(key: key);
  final bool hasError;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CostumButton(onPressed: onPressed, backgroundColor: hasError ? Colors.grey : null, childText: 'Submit');
  }
}

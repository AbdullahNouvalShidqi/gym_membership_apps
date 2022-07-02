import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/screen/forgot_password/forgot_password_view_model.dart';
import 'package:gym_membership_apps/screen/update_password/update_password_screen.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_dialog.dart';

import 'components.dart';

class OtpScreen extends StatefulWidget {
  static String routeName = '/otp';
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool hasError = true;
  final _otpController = TextEditingController();
  int time = 120;
  Timer? _timer;

  void startTime() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (time == 0) {
          Fluttertoast.showToast(msg: 'Time is up, re-send otp email if you want');
          setState(() {
            hasError = true;
          });
          timer.cancel();
        } else {
          setState(() {
            time--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const MainTitle(),
                  CostumPinCodeTextField(
                    otpController: _otpController,
                    hasError: hasError,
                    onChanged: costumPinOnChanged,
                  ),
                  const SizedBox(height: 6),
                  hasError
                      ? const Text(
                          'Please enter a valid OTP',
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  Text('00:$time Sec', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  ResendOTP(resetTime: resetTime),
                  const SizedBox(height: 15),
                  SubmitButton(hasError: hasError, onPressed: submitButtonOnPressed)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void costumPinOnChanged(String newValue) {
    if (newValue.isEmpty || newValue.length < 4 || time == 0) {
      if (time == 0) {
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: 'Time is already up, re-send your otp again to reset password');
      }
      setState(() {
        hasError = true;
      });
      return;
    } else {
      setState(() {
        hasError = false;
      });
    }
  }

  void resetTime() {
    setState(() {
      time = 120;
    });
  }

  void submitButtonOnPressed() {
    if (_otpController.text != ForgotPasswordViewModel.otp) {
      setState(() {
        hasError = true;
      });
    }
    if (hasError) return;
    _timer?.cancel();
    final id = ModalRoute.of(context)!.settings.arguments as int;
    Navigator.pushReplacementNamed(context, UpdatePasswordScreen.routeName, arguments: id);
  }

  Future<bool> onWillPop() async {
    bool willPop = false;
    await showDialog(
      context: context,
      builder: (context) {
        return CostumDialog(
          title: 'Exit?',
          contentText: 'If you exit you will go back to the main login screen, you sure?',
          trueText: 'Yes',
          falseText: 'Cancel',
          trueOnPressed: () {
            willPop = true;
            Navigator.pop(context);
          },
          falseOnPressed: () {
            Navigator.pop(context);
          },
        );
      },
    );
    return willPop;
  }
}

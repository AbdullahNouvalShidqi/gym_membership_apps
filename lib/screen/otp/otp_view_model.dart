import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/screen/forgot_password/forgot_password_view_model.dart';
import 'package:gym_membership_apps/screen/update_password/update_password_screen.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_dialog.dart';

class OtpViewModel with ChangeNotifier {
  int _time = 120;
  int get time => _time;

  bool _hasError = false;
  bool get hasError => _hasError;

  final _otpController = TextEditingController();
  TextEditingController get otpController => _otpController;

  void refreshTime() {
    _time--;
    notifyListeners();
  }

  void startTime() {
    _time = 120;
    notifyListeners();
  }

  void resetTime({required Timer timer, required void Function() startTimer}) {
    _hasError = false;
    if (!timer.isActive) {
      startTimer();
    }
    notifyListeners();
  }

  void setError(bool b) {
    _hasError = b;
    notifyListeners();
  }

  void costumPinOnChanged(String newValue) {
    if (newValue.isEmpty || newValue.length < 4 || time == 0) {
      if (_time == 0) {
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: 'Time is already up, re-send your otp again to reset password');
      }
      _hasError = true;
      notifyListeners();
      return;
    } else {
      _hasError = false;
    }
  }

  void submitButtonOnPressed(BuildContext context, Timer? timer) {
    if (_otpController.text != ForgotPasswordViewModel.otp) {
      _hasError = true;
      notifyListeners();
    }
    if (hasError) return;
    timer?.cancel();
    _otpController.text = '';
    final id = ModalRoute.of(context)!.settings.arguments as int;
    Navigator.pushReplacementNamed(context, UpdatePasswordScreen.routeName, arguments: id);
  }

  Future<bool> onWillPop(BuildContext context) async {
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
    if (willPop) {
      _otpController.text = '';
    }
    return willPop;
  }
}

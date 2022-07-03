import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_bottom_sheet.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_dialog.dart';

enum UpdatePasswordState { none, loading, error }

class UpdatePasswordViewModel with ChangeNotifier {
  UpdatePasswordState _state = UpdatePasswordState.none;
  UpdatePasswordState get state => _state;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _newPasswordCtrl = TextEditingController();
  TextEditingController get newPasswordCtrl => _newPasswordCtrl;

  final _confirmPasswordCtrl = TextEditingController();
  TextEditingController get confirmPasswordCtrl => _confirmPasswordCtrl;

  Future<bool> onWillPop(BuildContext context) async {
    bool willPop = false;
    await showDialog(
      context: context,
      builder: (context) {
        return CostumDialog(
          title: 'Exit ?',
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

  Future<void> appBarBackOnPressed(BuildContext context) async {
    final navigator = Navigator.of(context);
    bool willPop = false;
    await showDialog(
      context: context,
      builder: (context) {
        return CostumDialog(
          title: 'Exit ?',
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
      _newPasswordCtrl.text = '';
      _confirmPasswordCtrl.text = '';
      navigator.pop();
    }
  }

  void changeState(UpdatePasswordState s) {
    _state = s;
    notifyListeners();
  }

  Future<void> updatePassword({required int id, required String newPassword}) async {
    changeState(UpdatePasswordState.loading);

    try {
      await MainAPI().updatePassword(id: id, newPassword: newPassword);
      changeState(UpdatePasswordState.none);
    } catch (e) {
      changeState(UpdatePasswordState.error);
      if (e is DioError) {
        Fluttertoast.showToast(msg: e.message);
      }
    }
  }

  Future<void> updatePasswordOnPressed(BuildContext context, {required int id}) async {
    if (!_formKey.currentState!.validate()) return;

    final focusScope = FocusScope.of(context);

    focusScope.unfocus();

    await updatePassword(id: id, newPassword: _newPasswordCtrl.text);

    final isError = _state == UpdatePasswordState.error;

    if (isError) {
      Fluttertoast.showToast(msg: 'Error: Check your internet, or try again later');
      return;
    }

    _newPasswordCtrl.text = '';
    _confirmPasswordCtrl.text = '';

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return CostumBottomSheet(
          title: 'Password Recovery',
          content: 'Return to the login screen to enter the application',
          successful: true,
          buttonText: 'Return to login',
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        );
      },
    );
  }
}

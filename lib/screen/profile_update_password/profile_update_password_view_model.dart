import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_bottom_sheet.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_dialog.dart';

enum ProfileUpdatePasswordState { none, loading, error }

class ProfileUpdatePasswordViewModel with ChangeNotifier {
  ProfileUpdatePasswordState _state = ProfileUpdatePasswordState.none;
  ProfileUpdatePasswordState get state => _state;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _currentPwCtrl = TextEditingController();
  TextEditingController get currentPwCtrl => _currentPwCtrl;

  final _newPwCtrl = TextEditingController();
  TextEditingController get newPwCtrl => _newPwCtrl;

  final _confirmPwCtrl = TextEditingController();
  TextEditingController get confirmPwCtrl => _confirmPwCtrl;

  void changeState(ProfileUpdatePasswordState s) {
    _state = s;
    notifyListeners();
  }

  Future<void> updatePassword({required int id, required newPassword}) async {
    changeState(ProfileUpdatePasswordState.loading);

    try {
      await MainAPI().updatePassword(id: id, newPassword: newPassword);
      changeState(ProfileUpdatePasswordState.none);
    } catch (e) {
      changeState(ProfileUpdatePasswordState.error);
    }
  }

  Future<bool> onWillPop(BuildContext context) async {
    bool willPop = true;
    if (_currentPwCtrl.text.isNotEmpty || _newPwCtrl.text.isNotEmpty || _confirmPwCtrl.text.isNotEmpty) {
      willPop = false;
      await showDialog(
        context: context,
        builder: (context) {
          return CostumDialog(
            title: 'Watch it!',
            contentText: 'You sure want to exit, you will lost all your data that you have inputted',
            trueText: 'Yes',
            falseText: 'No',
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
    }
    if (willPop) {
      _currentPwCtrl.text = '';
      _newPwCtrl.text = '';
      _confirmPwCtrl.text = '';
    }
    return willPop;
  }

  Future<void> continueButtonOnTap(BuildContext context, {required ProfileViewModel profileViewModel}) async {
    if (!_formKey.currentState!.validate()) return;
    final focusScope = FocusScope.of(context);

    focusScope.unfocus();

    await updatePassword(id: profileViewModel.user.id!, newPassword: _newPwCtrl.text);
    await profileViewModel.getUserById(id: profileViewModel.user.id!);

    final isError =
        _state == ProfileUpdatePasswordState.error || profileViewModel.state == ProfileUpdatePasswordState.error;

    if (isError) {
      Fluttertoast.showToast(msg: 'Error: try again or check your internet connection');
      focusScope.requestFocus();
      return;
    }

    _currentPwCtrl.text = '';
    _newPwCtrl.text = '';
    _confirmPwCtrl.text = '';

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return CostumBottomSheet(
          title: 'Password Recovery',
          content: 'Return to the to profile screen to continue',
          buttonText: 'Return to profile screen',
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        );
      },
    );
  }
}

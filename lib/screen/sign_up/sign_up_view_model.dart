import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/model/user_model.dart';
import 'package:gym_membership_apps/screen/home/home_screen.dart';
import 'package:gym_membership_apps/screen/log_in/log_in_screen.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SignUpState { none, loading, error }

class SignUpViewModel with ChangeNotifier {
  late SharedPreferences _sharedPreferences;

  SignUpState _state = SignUpState.none;
  SignUpState get state => _state;

  UserModel? _user;
  UserModel? get user => _user;

  List<UserModel> _allUser = [];
  List<UserModel> get allUser => _allUser;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _emailCtrl = TextEditingController();
  TextEditingController get emailCtrl => _emailCtrl;

  final _phoneNumberCtrl = TextEditingController();
  TextEditingController get phoneNumberCtrl => _phoneNumberCtrl;

  final _usernameCtrl = TextEditingController();
  TextEditingController get usernameCtrl => _usernameCtrl;

  final _passwordCtrl = TextEditingController();
  TextEditingController get passwordCtrl => _passwordCtrl;

  final _confirmPasswordCtrl = TextEditingController();
  TextEditingController get confirmPasswordCtrl => _confirmPasswordCtrl;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  DateTime? currentBackPressTime;

  void changeState(SignUpState s) {
    _state = s;
    notifyListeners();
  }

  Future<void> signUpWithEmailAndPassword({
    required String username,
    required String email,
    required String contact,
    required String password,
  }) async {
    changeState(SignUpState.loading);
    try {
      _user = await MainAPI().signUp(username: username, email: email, contact: contact, password: password);
      changeState(SignUpState.none);
    } catch (e) {
      changeState(SignUpState.error);
    }
  }

  Future<void> getAllUser() async {
    changeState(SignUpState.loading);

    try {
      _allUser = await MainAPI().getAllUser();
      changeState(SignUpState.none);
    } catch (e) {
      changeState(SignUpState.error);
    }
  }

  Future<void> setRememberMe({required String email, required String password}) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {'email': email, 'password': password};
    await _sharedPreferences.setString('rememberMe', jsonEncode(data));
  }

  Future<void> dontRememberMe() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.remove('rememberMe');
  }

  void rememberMeCheckBoxOnTap(bool? newValue) {
    _rememberMe = newValue!;
    notifyListeners();
  }

  void rememberMeLabelOnTap() {
    _rememberMe = !_rememberMe;
    notifyListeners();
  }

  Future<bool> willPopValidation(BuildContext context) async {
    if (_usernameCtrl.text.isNotEmpty ||
        _emailCtrl.text.isNotEmpty ||
        _phoneNumberCtrl.text.isNotEmpty ||
        _passwordCtrl.text.isNotEmpty) {
      bool willPop = false;
      await showDialog(
        context: context,
        builder: (context) {
          return CostumDialog(
            title: 'Whoa! Take it easy',
            contentText: 'You will lost your input data to sign up, still want to exit?',
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
      _rememberMe = false;
      return willPop;
    } else {
      DateTime now = DateTime.now();
      if ((currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) &&
          ModalRoute.of(context)!.isFirst) {
        currentBackPressTime = now;
        Fluttertoast.showToast(msg: 'Press back again to exit');
        return false;
      }
      _rememberMe = false;
      return true;
    }
  }

  Future<void> signUpButtonOnPressed(BuildContext context) async {
    final navigator = Navigator.of(context);
    final focusScope = FocusScope.of(context);

    focusScope.unfocus();
    await getAllUser();

    if (!_formKey.currentState!.validate()) return;

    await signUpWithEmailAndPassword(
      username: _usernameCtrl.text,
      email: _emailCtrl.text,
      contact: _phoneNumberCtrl.text,
      password: _passwordCtrl.text,
    );

    final isError = _state == SignUpState.error;

    if (isError) {
      Fluttertoast.showToast(msg: 'Error : Check your internet connection or try again');
      return;
    }

    if (_rememberMe) {
      await setRememberMe(email: _user!.email, password: _user!.password);
    } else {
      await dontRememberMe();
    }

    ProfileViewModel.setUserData(currentUser: _user!);
    Fluttertoast.showToast(msg: 'Sign up succesful!');
    navigator.pushReplacementNamed(HomeScreen.routeName);
  }

  Future<void> toLoginOnTap(BuildContext context) async {
    final navigator = Navigator.of(context);
    if (_usernameCtrl.text.isNotEmpty ||
        _emailCtrl.text.isNotEmpty ||
        _phoneNumberCtrl.text.isNotEmpty ||
        _passwordCtrl.text.isNotEmpty) {
      bool willPop = false;
      await showDialog(
          context: context,
          builder: (context) {
            return CostumDialog(
              title: 'Whoa! Take it easy',
              contentText: 'You will lost your input data to sign up, still want to exit?',
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
          });
      if (willPop) {
        navigator.pushReplacementNamed(LogInScreen.routeName);
      }
      return;
    }
    navigator.pushReplacementNamed(LogInScreen.routeName);
  }
}

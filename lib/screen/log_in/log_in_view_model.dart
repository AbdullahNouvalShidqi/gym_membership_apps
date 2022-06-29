import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/model/user_model.dart';
import 'package:gym_membership_apps/screen/home/home_screen.dart';
import 'package:gym_membership_apps/screen/log_in/log_in_screen.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/sign_up/sign_up_screen.dart';
import 'package:gym_membership_apps/utilitites/costum_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LogInState { none, loading, error }

class LogInViewModel with ChangeNotifier {
  late SharedPreferences _sharedPreferences;

  DateTime? _currentBackPressTime;

  static UserModel? currentUser;

  static List<UserModel> allUser = [];

  LogInState _state = LogInState.none;
  LogInState get state => _state;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _emailCtrl = TextEditingController();
  TextEditingController get emailCtrl => _emailCtrl;

  final _passwordCtrl = TextEditingController();
  TextEditingController get passwordCtrl => _passwordCtrl;

  void changeState(LogInState s) {
    _state = s;
    notifyListeners();
  }

  void disposeTest() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
  }

  void setEmailAndPassword() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_sharedPreferences.getString('rememberMe') == null) return;

    final Map<String, dynamic> userData = jsonDecode(_sharedPreferences.getString('rememberMe')!);
    _emailCtrl.text = userData['email'];
    _passwordCtrl.text = userData['password'];
    _rememberMe = true;
    notifyListeners();
  }

  Future<void> signIn({required String email, required String password}) async {
    changeState(LogInState.loading);
    try {
      currentUser = UserModel(username: 'AbdullahNS', email: email, contact: '087823232237', password: password);
      await Future.delayed(const Duration(seconds: 1));
      changeState(LogInState.none);
    } catch (e) {
      changeState(LogInState.error);
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

  Future<List<UserModel>> getAllUser() async {
    changeState(LogInState.loading);
    try {
      allUser = await MainAPI().getAllUser();
      changeState(LogInState.none);
    } catch (e) {
      changeState(LogInState.error);
    }
    return allUser;
  }

  void rememberMeCheckBoxOnTap(bool? newValue) {
    _rememberMe = newValue!;
    notifyListeners();
  }

  void rememberMeLabelOnTap() {
    _rememberMe = !_rememberMe;
    notifyListeners();
  }

  Future<bool> Function() willPopValidation(BuildContext context) {
    return () async {
      if (_emailCtrl.text.isNotEmpty || _passwordCtrl.text.isNotEmpty) {
        bool willPop = false;
        await showDialog(
          context: context,
          builder: (context) {
            return CostumDialog(
              title: 'Exit?',
              contentText: "You will lose your data you've filled!",
              trueText: 'Exit',
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
        _emailCtrl.text = '';
        _passwordCtrl.text = '';
        return willPop;
      } else {
        DateTime now = DateTime.now();
        if ((_currentBackPressTime == null || now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) &&
            ModalRoute.of(context)!.isFirst) {
          _currentBackPressTime = now;
          Fluttertoast.showToast(msg: 'Press back again to exit');
          return Future.value(false);
        }
        return Future.value(true);
      }
    };
  }

  Future<void> Function() signUpButtonOnTap(BuildContext context) {
    final navigator = Navigator.of(context);
    return () async {
      if (_emailCtrl.text.isNotEmpty || _passwordCtrl.text.isNotEmpty) {
        bool willPop = false;
        await showDialog(
          context: context,
          builder: (context) {
            return CostumDialog(
              title: 'Whoa! Take it easy',
              contentText: 'You will lost your input data to login, still want to exit?',
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
        if (willPop) {
          navigator.pushReplacementNamed(SignUpScreen.routeName);
        }
        return;
      }
      navigator.pushReplacementNamed(SignUpScreen.routeName);
    };
  }

  void Function() loginButtonOnTap(BuildContext context) {
    return () async {
      if (!_formKey.currentState!.validate()) return;

      final navigator = Navigator.of(context);
      final allUser = await getAllUser();
      final email = _emailCtrl.text.toLowerCase();
      final isError = _state == LogInState.error;

      if (isError) {
        Fluttertoast.showToast(msg: 'Error: Something went wrong, try again');
        return;
      }

      final userData = allUser.where((element) => element.email.toLowerCase() == email).toList();

      if (userData.isEmpty || userData.length > 1 || userData.first.password != _passwordCtrl.text) {
        Fluttertoast.showToast(msg: 'Sign in failed, check your email and password');
        return;
      }

      if (_rememberMe) {
        await setRememberMe(email: userData.first.email, password: userData.first.password);
      } else {
        await dontRememberMe();
      }

      ProfileViewModel.setUserData(currentUser: userData.first);

      Fluttertoast.showToast(msg: 'Log in successful!');
      navigator.pushReplacementNamed(HomeScreen.routeName);
    };
  }
}

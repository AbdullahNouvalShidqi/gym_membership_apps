import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/api/email_js_api.dart';

enum ForgotPasswordState {none, loading, error}

class ForgotPasswordViewModel with ChangeNotifier{
  static String _otp = '';
  static String get otp => _otp;

  static String _encryptedEmail = '';
  static String get encryptedEmail => _encryptedEmail;

  static String _email = '';
  static String get validEmail => _email;

  ForgotPasswordState _state = ForgotPasswordState.none;
  ForgotPasswordState get state => _state;

  void changeState(ForgotPasswordState s){
    _state = s;
    notifyListeners();
  }

  Future<void> sendOTP({required String email}) async {
    changeState(ForgotPasswordState.loading);

    try{
      _otp = await EmailJsAPI.sendOTP(email: email);
      _email = email;
      
      int j = 0;
      for(var i = 0; i < email.length; i++){
        if(email[i] == '@'){
          j = i;
        }
      }
      for(j; j >= 3; j--){
        email = email.replaceRange(j, j+1, '*');
      }
      _encryptedEmail = email;

      Fluttertoast.showToast(msg: 'OTP has sent to your email');
      changeState(ForgotPasswordState.none);
    }
    catch(e){
      if(e is DioError){
        Fluttertoast.showToast(msg: e.message);
      }
      changeState(ForgotPasswordState.error);
    }
  }

  Future<void> resendOTP() async {
    changeState(ForgotPasswordState.loading);
    try{
      _otp = await EmailJsAPI.sendOTP(email: _email);
      Fluttertoast.showToast(msg: 'OTP has resend to your email');
      changeState(ForgotPasswordState.none);
    }
    catch(e){
      changeState(ForgotPasswordState.error);
    }
  }
}
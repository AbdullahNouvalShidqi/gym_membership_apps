import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SignUpState{
  none,
  loading,
  error
}

class SignUpViewModel with ChangeNotifier{
  late SharedPreferences _sharedPreferences;

  SignUpState _state = SignUpState.none;
  SignUpState get state => _state;

  UserModel? _user;
  UserModel? get user => _user;

  List<UserModel> _allUser = [];
  List<UserModel> get allUser => _allUser;

  void changeState(SignUpState s){
    _state = s;
    notifyListeners();
  }
  
  Future<void> signUpWithEmailAndPassword({
    required String username, 
    required String email, 
    required String contact, 
    required String password
  }) async {
    changeState(SignUpState.loading);
    try{
      _user = await MainAPI().signUp(username: username, email: email, contact: contact, password: password);
      changeState(SignUpState.none);
    }
    catch(e){
      changeState(SignUpState.error);
    }
    
  }

  Future<void> getAllUser() async {
    changeState(SignUpState.loading);

    try{
      _allUser = await MainAPI().getAllUser();
      changeState(SignUpState.none);
    }catch(e){      
      changeState(SignUpState.error);
    }
  }

  Future<void> rememberMe({required String email, required String password}) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {
      'email' : email,
      'password' : password
    };
    await _sharedPreferences.setString('rememberMe', jsonEncode(data));
  }
}
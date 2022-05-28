import 'package:flutter/cupertino.dart';
import 'package:gym_membership_apps/model/user_model.dart';

class ProfileViewModel with ChangeNotifier{
  UserModel _user = UserModel();
  UserModel get user => _user;

  void setUserData({required String username, required String emailAddress, required String phoneNumber, required String password}){
    _user = UserModel(emailAddress: emailAddress, username: username, phoneNumber: phoneNumber, password: password);
    notifyListeners();
  }
}
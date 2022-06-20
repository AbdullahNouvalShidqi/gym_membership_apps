import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/model/user_model.dart';

enum LogInState {none, loading, error}

class LogInViewModel with ChangeNotifier{

  static UserModel? currentUser;

  static List<UserModel> allUser = [];

  LogInState _state = LogInState.none;
  LogInState get state => _state;

  void changeState(LogInState s){
    _state = s;
    notifyListeners();
  }
  
  Future<void> signIn({required String email, required String password}) async {
    changeState(LogInState.loading);
    try{
      currentUser = UserModel(username: 'AbdullahNS', email: email, contact: '087823232237', password: password);
      await Future.delayed(const Duration(seconds: 1));
      changeState(LogInState.none);
    }
    catch(e){
      changeState(LogInState.error);
    }
  }

  Future<List<UserModel>> getAllUser() async {
    changeState(LogInState.loading);
    try{
      allUser = await MainAPI().getAllUser();
      changeState(LogInState.none);
    }
    catch(e){
      if(e is DioError){
        Fluttertoast.showToast(msg: e.message);
      }
      changeState(LogInState.error);
    }
    return allUser;
  }
}
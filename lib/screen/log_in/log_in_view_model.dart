import 'package:flutter/cupertino.dart';
import 'package:gym_membership_apps/model/user_model.dart';

enum LogInState {none, loading, error}

class LogInViewModel with ChangeNotifier{

  static UserModel? currentUser;

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
}
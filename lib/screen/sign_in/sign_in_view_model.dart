import 'package:flutter/cupertino.dart';
import 'package:gym_membership_apps/model/user_model.dart';

enum SignInState {none, loading, error}

class SignInViewModel with ChangeNotifier{

  static UserModel? currentUser;

  SignInState _state = SignInState.none;
  SignInState get state => _state;

  void changeState(SignInState s){
    _state = s;
    notifyListeners();
  }
  
  Future<void> signIn({required String email, required String password}) async {
    changeState(SignInState.loading);
    try{
      currentUser = UserModel(username: 'AbdullahNS', email: email, contact: '087823232237', password: password);
      await Future.delayed(const Duration(seconds: 1));
      changeState(SignInState.none);
    }
    catch(e){
      changeState(SignInState.error);
    }
  }
}
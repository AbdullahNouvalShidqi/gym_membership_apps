import 'package:flutter/cupertino.dart';

enum SignInState {none, loading, error}

class SignInViewModel with ChangeNotifier{

  SignInState _state = SignInState.none;
  SignInState get state => _state;

  void changeState(SignInState s){
    _state = s;
    notifyListeners();
  }
  
  Future<void> signIn({required String email, required String password}) async {
    changeState(SignInState.loading);
    try{
      await Future.delayed(const Duration(seconds: 1));
      changeState(SignInState.none);
    }
    catch(e){
      changeState(SignInState.error);
    }
  }
}
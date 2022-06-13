import 'package:flutter/cupertino.dart';

enum SignUpState{
  none,
  loading,
  error
}

class SignUpViewModel with ChangeNotifier{

  SignUpState _state = SignUpState.none;
  SignUpState get state => _state;

  void changeState(SignUpState s){
    _state = s;
    notifyListeners();
  }
  
  Future<void> signUpWithEmailAndPassword({
    required String username, 
    required String emailAddress, 
    required String phoneNumber, 
    required String password
  }) async {
    changeState(SignUpState.loading);
    try{
      await Future.delayed(const Duration(seconds: 3));
      changeState(SignUpState.none);
    }
    catch(e){
      changeState(SignUpState.error);
    }
    
  }
}
import 'package:flutter/cupertino.dart';
import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/model/user_model.dart';

enum SignUpState{
  none,
  loading,
  error
}

class SignUpViewModel with ChangeNotifier{

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
}
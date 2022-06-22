import 'package:flutter/cupertino.dart';
import 'package:gym_membership_apps/model/class_model.dart';

enum AvailableClassState {none, loading, error}

class AvailableClassViewModel with ChangeNotifier{

  List<ClassModel> _availableClasses = [];
  List<ClassModel> get availableClasses => _availableClasses;

  AvailableClassState _state = AvailableClassState.none;
  AvailableClassState get state => _state;

  void changeState(AvailableClassState s){
    _state = s;
    notifyListeners();
  }

  Future<void> getAvailableClasses() async {
    changeState(AvailableClassState.loading);

    try{
      await Future.delayed(const Duration(seconds: 2));
      changeState(AvailableClassState.none);
    }
    catch(e){
      changeState(AvailableClassState.error);
    }
  }

  Future<void> refreshData() async {
    try{
      await Future.delayed(const Duration(seconds: 2));
      changeState(AvailableClassState.none);
    }
    catch(e){
      changeState(AvailableClassState.error);
    }
  }
}
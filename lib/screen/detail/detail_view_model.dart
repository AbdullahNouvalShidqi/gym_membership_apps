import 'package:flutter/cupertino.dart';
import 'package:gym_membership_apps/model/class_model.dart';

enum DetailState {none, loading, error}

class DetailViewModel with ChangeNotifier{
  ClassModel? _classDetail;
  ClassModel? get classDetail => _classDetail;

  DetailState _state = DetailState.none;
  DetailState get state => _state;

  void changeState(DetailState s){
    _state = s;
    notifyListeners();
  }

  Future<void> getDetail() async {
    changeState(DetailState.loading);

    try{
      await Future.delayed(const Duration(seconds: 2));
      changeState(DetailState.none);
    }
    catch(e){
      changeState(DetailState.error);
    }
  }
}
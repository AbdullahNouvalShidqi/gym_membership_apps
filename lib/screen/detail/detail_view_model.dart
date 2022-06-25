import 'package:flutter/cupertino.dart';
import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/model/home_class_model.dart';

enum DetailState {none, loading, error}

class DetailViewModel with ChangeNotifier{
  List<ClassModel> _classDetail = [];
  List<ClassModel> get classDetail => _classDetail;

  DetailState _state = DetailState.none;
  DetailState get state => _state;

  void changeState(DetailState s){
    _state = s;
    notifyListeners();
  }

  Future<ClassModel?> getDetail({required HomeClassModel item, required String type}) async {
    changeState(DetailState.loading);

    try{
      _classDetail = await MainAPI().getAllClass(type: type);
      _classDetail = _classDetail.where((e) => e.name == item.name && e.type == type).toList();
      if(_classDetail.isNotEmpty){
        _classDetail.first.images = item.images;
        _classDetail.first.description = item.description;
      }
      changeState(DetailState.none);
    }
    catch(e){
      changeState(DetailState.error);
    }
    if(_classDetail.isEmpty)return null;
    return _classDetail.first;
  }

  Future<ClassModel?> refreshDetail({required HomeClassModel item, required String type}) async {
    
    try{
      _classDetail = await MainAPI().getAllClass(type: type);
      _classDetail = _classDetail.where((e) => e.name == item.name && e.type == type).toList();
      if(_classDetail.isNotEmpty){
        _classDetail.first.images = item.images;
        _classDetail.first.description = item.description;
      }
      changeState(DetailState.none);
    }
    catch(e){
      changeState(DetailState.error);
    }
    if(_classDetail.isEmpty)return null;
    return _classDetail.first;
  }
}
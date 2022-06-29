import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/model/class_model.dart';

enum AvailableClassState { none, loading, error }

class AvailableClassViewModel with ChangeNotifier {
  List<ClassModel> _availableClasses = [];
  List<ClassModel> get availableClasses => _availableClasses;

  ClassModel? _currentItems;

  AvailableClassState _state = AvailableClassState.none;
  AvailableClassState get state => _state;

  Future<bool> onWillPop() async {
    changeState(AvailableClassState.none);
    notifyListeners();

    return true;
  }

  void changeState(AvailableClassState s) {
    _state = s;
    notifyListeners();
  }

  Future<void> getAvailableClasses({required ClassModel item}) async {
    changeState(AvailableClassState.loading);

    try {
      _currentItems = item;
      _availableClasses = await MainAPI().getAllClass(type: item.type);
      _availableClasses = _availableClasses.where((element) => element.name == item.name).toList();
      for (var i = 0; i < _availableClasses.length; i++) {
        _availableClasses[i].images = [...item.images];
      }
      changeState(AvailableClassState.none);
    } catch (e) {
      changeState(AvailableClassState.error);
    }
  }

  Future<void> refreshData() async {
    try {
      final currentClasses = [..._availableClasses];
      _availableClasses = await MainAPI().getAllClass(type: _currentItems!.type);
      _availableClasses = _availableClasses.where((element) => element.name == _currentItems!.name).toList();
      for (var i = 0; i < _availableClasses.length; i++) {
        _availableClasses[i].images = [..._currentItems!.images];
      }
      if (currentClasses.length == _availableClasses.length) {
        Fluttertoast.showToast(msg: 'No new data was found');
      }
    } catch (e) {
      changeState(AvailableClassState.error);
    }
  }
}

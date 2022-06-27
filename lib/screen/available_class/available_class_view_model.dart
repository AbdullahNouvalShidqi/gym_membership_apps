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

  void changeState(AvailableClassState s) {
    _state = s;
    notifyListeners();
  }

  Future<void> getAvailableClasses({required ClassModel item}) async {
    changeState(AvailableClassState.loading);

    try {
      _currentItems = item;
      _availableClasses = await MainAPI().getAllClass(type: item.type);
      // [
      //   ClassModel(
      //     id: 5,
      //     name: 'Zumba',
      //     description: 'Cardio is defined as any type of exercise that gets your heart rate up and keeps it up for a prolonged period of time.',
      //     startAt: DateTime.now(),
      //     endAt: DateTime.now().add(const Duration(hours: 3)),
      //     qtyUsers: 25,
      //     type: 'Online',
      //     images: ['cardio.png'],
      //     instructor: InstructorModel(id: 4, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com'),
      //     price: 300000,
      //     location: 'Room A'
      //   ),
      // ];
      // print(DateTime.now());
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

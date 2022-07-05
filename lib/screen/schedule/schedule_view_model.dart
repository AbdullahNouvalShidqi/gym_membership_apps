import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/model/book_model.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

enum ScheduleViewState { none, loading, error }

class ScheduleViewModel with ChangeNotifier {
  ScheduleViewState _state = ScheduleViewState.none;
  ScheduleViewState get state => _state;

  List<ClassModel> _listSchedule = [];
  List<ClassModel> get listSchedule => _listSchedule;

  List<ClassModel> _tempSchedules = [];
  List<ClassModel> get tempSchedules => _tempSchedules;

  List<BookModel> _listBookedClasses = [];
  List<BookModel> get listBookedClasses => _listBookedClasses;

  int _currentId = 0;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  static bool isInit = true;

  final ScrollController _scheduleListController = ScrollController();
  ScrollController get scheduleListController => _scheduleListController;

  final List<Map<String, String?>> _buttonsData = [
    {
      'icon': null,
      'name': 'All',
    },
    {
      'icon': 'assets/icons/buttonIcon1.svg',
      'name': 'Status',
    },
    {
      'icon': 'assets/icons/buttonIcon2.svg',
      'name': 'Time',
    },
    {
      'icon': 'assets/icons/buttonIcon3.svg',
      'name': 'Class',
    },
  ];

  List<Map<String, String?>> get buttonsData => _buttonsData;

  static void isInitDone() {
    isInit = false;
  }

  void changeState(ScheduleViewState s) {
    _state = s;
    notifyListeners();
  }

  Future<void> getInitSchedule({required int id}) async {
    _currentId = id;
    changeState(ScheduleViewState.loading);
    try {
      _listBookedClasses = await MainAPI().getSchedulesById(id: id);
      if (_listBookedClasses.isNotEmpty) {
        _listSchedule = _listBookedClasses.map((e) => e.bookedClasses).toList();
        for (var i = 0; i < _listSchedule.length; i++) {
          final name = _listSchedule[i].name.replaceAll(' ', '').toLowerCase();
          for (var j = 0; j < 3; j++) {
            _listSchedule[i].images.add('assets/$name${j == 0 ? '' : j}.png');
          }
        }
        for (var i = 0; i < _listSchedule.length; i++) {
          _listSchedule[i].status = checkStatus(_listBookedClasses[i]);
        }
        _tempSchedules = [..._listSchedule];
      }
      changeState(ScheduleViewState.none);
    } catch (e) {
      changeState(ScheduleViewState.error);
    }
  }

  Future<void> pullToRefresh() async {
    try {
      int currentLength = _listSchedule.length;
      _listBookedClasses = await MainAPI().getSchedulesById(id: _currentId);
      if (_listBookedClasses.isNotEmpty) {
        _listSchedule = _listBookedClasses.map((e) => e.bookedClasses).toList();
        for (var i = 0; i < _listSchedule.length; i++) {
          final name = _listSchedule[i].name.replaceAll(' ', '').toLowerCase();
          for (var j = 0; j < 3; j++) {
            _listSchedule[i].images.add('assets/$name${j == 0 ? '' : j}.png');
          }
        }
        for (var i = 0; i < _listSchedule.length; i++) {
          _listSchedule[i].status = checkStatus(_listBookedClasses[i]);
        }
        _tempSchedules = [..._listSchedule];
      }
      if (_listSchedule.length < currentLength) {
        Fluttertoast.showToast(msg: 'Some data are deleted');
      } else if (_listSchedule.length > currentLength) {
        Fluttertoast.showToast(msg: 'New data added to your schedule');
      } else {
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: 'No new data found in your schedule');
      }
      changeState(ScheduleViewState.none);
    } catch (e) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: 'Error: Cannot get data, check your internet connection');
      changeState(ScheduleViewState.error);
    }
  }

  Future<void> refreshData() async {
    try {
      int currentLength = _listSchedule.length;
      _listBookedClasses = await MainAPI().getSchedulesById(id: _currentId);
      if (_listBookedClasses.isNotEmpty) {
        _listSchedule = _listBookedClasses.map((e) => e.bookedClasses).toList();
        for (var i = 0; i < _listSchedule.length; i++) {
          final name = _listSchedule[i].name.replaceAll(' ', '').toLowerCase();
          for (var j = 0; j < 3; j++) {
            _listSchedule[i].images.add('assets/$name${j == 0 ? '' : j}.png');
          }
        }
        for (var i = 0; i < _listSchedule.length; i++) {
          _listSchedule[i].status = checkStatus(_listBookedClasses[i]);
        }
        _tempSchedules = [..._listSchedule];
      }
      if (_listSchedule.length < currentLength) {
        Fluttertoast.showToast(msg: 'Some data are deleted');
      } else if (_listSchedule.length > currentLength) {
        Fluttertoast.showToast(msg: 'New data added to your schedule');
      }
      changeState(ScheduleViewState.none);
    } catch (e) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: 'Error: Cannot get data, check your internet connection');
      changeState(ScheduleViewState.error);
    }
  }

  Future<void> addToSchedule({required ClassModel newClass}) async {
    changeState(ScheduleViewState.loading);

    try {
      await Future.delayed(const Duration(seconds: 1));
      _listSchedule = [newClass, ..._listSchedule];
      for (var i = 0; i < _listSchedule.length; i++) {
        final name = _listSchedule[i].name.replaceAll(' ', '').toLowerCase();
        for (var j = 0; j < 3; j++) {
          _listSchedule[i].images.add('assets/$name${j == 0 ? '' : j}.png');
        }
      }
      for (var i = 0; i < _listSchedule.length; i++) {
        _listSchedule[i].status = checkStatus(_listBookedClasses[i]);
      }
      _tempSchedules = [..._listSchedule];
      changeState(ScheduleViewState.none);
    } catch (e) {
      changeState(ScheduleViewState.error);
    }
  }

  Future<void> booking({required int classId, required int idUser}) async {
    changeState(ScheduleViewState.loading);

    try {
      await MainAPI().bookClass(classId: classId, idUser: idUser);
      _listBookedClasses = await MainAPI().getSchedulesById(id: _currentId);
      if (_listBookedClasses.isNotEmpty) {
        _listSchedule = _listBookedClasses.map((e) => e.bookedClasses).toList();
      }
      changeState(ScheduleViewState.none);
    } catch (e) {
      changeState(ScheduleViewState.error);
    }
  }

  String checkStatus(BookModel bookedClass) {
    final now = DateTime.now().toUtc().add(DateTime.now().timeZoneOffset);
    if (bookedClass.isBooked) {
      return 'Accepted';
    }
    if (now.isAfter(bookedClass.bookedClasses.startAt) && !bookedClass.isBooked) {
      return 'Late';
    }
    return 'Waiting';
  }

  void resetSort() {
    _tempSchedules = [..._listSchedule];
    notifyListeners();
  }

  void logOut() {
    _listSchedule.clear();
    _tempSchedules.clear();
    isInit = true;
  }

  void sortingButtonOnTap({required int i, required AnimationController animationController}) {
    if (_currentIndex != i) {
      _currentIndex = i;
      notifyListeners();

      animationController
          .reverse()
          .then(
            (value) => checkSchedules(),
          )
          .then(
            (value) => animationController.forward(),
          );
    }
  }

  void checkSchedules() {
    if (currentIndex == 0) {
      resetSort();
    }
    if (currentIndex == 1) {
      _tempSchedules.sort((a, b) {
        if (a.status!.toLowerCase() == 'late') {
          return b.status!.compareTo(a.status!);
        }
        return a.status!.compareTo(b.status!);
      });
    }
    if (currentIndex == 2) {
      _tempSchedules.sort(
        (a, b) => a.startAt.compareTo(b.startAt),
      );
    }
    if (currentIndex == 3) {
      _tempSchedules.sort(
        (a, b) => a.name.compareTo(b.name),
      );
    }
    notifyListeners();
  }
}

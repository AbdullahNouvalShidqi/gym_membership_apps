import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/model/article_model.dart';
import 'package:gym_membership_apps/model/home_class_model.dart';
import 'package:gym_membership_apps/utilitites/tab_navigator.dart';

enum HomeViewState { none, loading, error }

class HomeViewModel with ChangeNotifier {
  HomeViewState _state = HomeViewState.none;
  HomeViewState get state => _state;

  void changeState(HomeViewState s) {
    _state = s;
    notifyListeners();
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  String _currentPage = 'Home';
  String get currentPage => _currentPage;

  DateTime? currentBackPressTime;

  final List<String> _pageKeys = ["Home", "Schedule", "Profile"];
  List<String> get pageKeys => _pageKeys;

  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Schedule": GlobalKey<NavigatorState>(),
    "Profile": GlobalKey<NavigatorState>(),
  };

  Map<String, GlobalKey<NavigatorState>> get navigatorKeys => _navigatorKeys;
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKeys[_currentPage]!;

  final ScrollController _homeScrollController = ScrollController();
  ScrollController get homeScrollController => _homeScrollController;

  void selectTab(String tabItem, int index) async {
    if (tabItem == _currentPage) {
      final isNotFirstRouteInCurrentTab = _navigatorKeys[_currentPage]!.currentState!.canPop();
      DateTime now = DateTime.now();
      if ((currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(milliseconds: 2000)) &&
          isNotFirstRouteInCurrentTab) {
        currentBackPressTime = now;
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: "Press $_currentPage again to main page of $_currentPage");
        return;
      } else if (tabItem == _currentPage &&
          _homeScrollController.offset != _homeScrollController.position.minScrollExtent &&
          !isNotFirstRouteInCurrentTab) {
        _homeScrollController.animateTo(_homeScrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 500), curve: Curves.easeOutQuart);
        return;
      }
      currentBackPressTime = null;
      Fluttertoast.cancel();
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      _currentPage = pageKeys[index];
      _selectedIndex = index;
      notifyListeners();
    }
  }

  Widget buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }

  Future<bool> onWillPop() async {
    final isNotFirstRouteInCurrentTab = await navigatorKey.currentState!.maybePop();
    if (isNotFirstRouteInCurrentTab) {
      return false;
    } else if (_currentPage != "Home") {
      selectTab("Home", 0);
      return false;
    } else {
      DateTime now = DateTime.now();
      if ((currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(milliseconds: 2000)) &&
          !isNotFirstRouteInCurrentTab) {
        currentBackPressTime = now;
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: 'Press back again to exit');
        return false;
      }
      currentBackPressTime = null;
      Fluttertoast.cancel();
      return true;
    }
  }

  List<HomeClassModel> _classes = [];
  List<HomeClassModel> get classes => _classes;

  List<ArticleModel> _articles = [];
  List<ArticleModel> get articles => _articles;

  Future<List<HomeClassModel>> getInitData() async {
    changeState(HomeViewState.loading);

    try {
      _classes = await MainAPI().getHomeClass();
      _articles = await MainAPI().getArticles();

      changeState(HomeViewState.none);
    } catch (e) {
      if (e is DioError) {
        Fluttertoast.showToast(msg: e.message);
      }
      changeState(HomeViewState.error);
    }
    return _classes;
  }

  Future<void> refreshData() async {
    try {
      final currentLength = _classes.length + _articles.length;
      _classes = await MainAPI().getHomeClass();
      _articles = await MainAPI().getArticles();
      final afterRefreshLength = _classes.length + _articles.length;

      changeState(HomeViewState.none);
      if (currentLength != afterRefreshLength) {
        Fluttertoast.showToast(msg: 'New data found');
        return;
      }
      Fluttertoast.showToast(msg: 'No new data found');
    } catch (e) {
      changeState(HomeViewState.error);
    }
  }
}

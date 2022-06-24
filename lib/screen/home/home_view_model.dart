import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/model/article_model.dart';
import 'package:gym_membership_apps/model/home_class_model.dart';
import 'package:gym_membership_apps/utilitites/tab_navigator.dart';

enum HomeViewState {none, loading, error}

class HomeViewModel with ChangeNotifier{

  HomeViewState _state = HomeViewState.none;
  HomeViewState get state => _state;

  void changeState(HomeViewState s){
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
    "Home" : GlobalKey<NavigatorState>(),
    "Schedule" : GlobalKey<NavigatorState>(),
    "Profile" : GlobalKey<NavigatorState>(),
  };

  Map<String, GlobalKey<NavigatorState>> get navigatorKeys => _navigatorKeys;
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKeys[_currentPage]!;

  final ScrollController _homeScrollController = ScrollController();
  ScrollController get homeScrollController => _homeScrollController;

  void selectTab(String tabItem, int index) async{
    if(tabItem == _currentPage){
      final isNotFirstRouteInCurrentTab = _navigatorKeys[_currentPage]!.currentState!.canPop();
      DateTime now = DateTime.now();
      if((currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(milliseconds: 2000)) && isNotFirstRouteInCurrentTab){
        currentBackPressTime = now;
        Fluttertoast.cancel();
        Fluttertoast.showToast(
          msg: "Press $_currentPage again to main page of $_currentPage"
        );
        return;
      }
      else if(tabItem == _currentPage && _homeScrollController.offset != _homeScrollController.position.minScrollExtent && !isNotFirstRouteInCurrentTab){
        _homeScrollController.animateTo(_homeScrollController.position.minScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.easeOutQuart);
        return;
      }
      currentBackPressTime = null;
      Fluttertoast.cancel();
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    }else{
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
    if(isNotFirstRouteInCurrentTab){
      return false;
    }
    else if(_currentPage != "Home"){
      selectTab("Home", 0);
      return false;
    }
    else{
      DateTime now = DateTime.now();
      if((currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(milliseconds: 2000)) && !isNotFirstRouteInCurrentTab){
        currentBackPressTime = now;
        Fluttertoast.cancel();
        Fluttertoast.showToast(
          msg: 'Press back again to exit'
        );
        return false;
      }
      currentBackPressTime = null;
      Fluttertoast.cancel();
      return true;
    }
  }

  List<HomeClassModel> _classes = [];

  List<HomeClassModel> get classes => _classes;

  Future<List<HomeClassModel>> getInitData() async {
    changeState(HomeViewState.loading);

    try{
      _classes = await MainAPI().getHomeClass();

      changeState(HomeViewState.none);
    }
    catch(e){
      if(e is DioError){
        Fluttertoast.showToast(msg: e.message);
      }
      changeState(HomeViewState.error);
    }
    return _classes;
  }

  final List<ArticleModel> _articles = [
    ArticleModel(
      imageUrl: 'https://gethealthyu.com/wp-content/uploads/2021/11/fitness-tips-500x500.png.webp',
      title: "101 Fitness Tips That Rock (From a Personal Trainer!)",
      url: 'https://gethealthyu.com/101-fitness-tips-that-rock/'
    ),
    ArticleModel(
      imageUrl: 'https://www.mensjournal.com/wp-content/uploads/mf/1280-improve-performance.jpg?w=900&quality=86&strip=all',
      title: "25 Expert Fitness Tips and Strategies Every Lifter Should Know",
      url: 'https://www.mensjournal.com/health-fitness/25-expert-fitness-tips-and-strategies-every-lifter-should-know/'
    ),
    ArticleModel(
      imageUrl: 'https://www.planetfitness.com/sites/default/files/feature-image/PF14209_LowRes%20%281%29.jpg',
      title: "7 MOTIVATING GYM TIPS FOR BEGINNERS",
      url: 'https://www.planetfitness.com/community/articles/7-motivating-gym-tips-beginners'
    ),
  ];

  List<ArticleModel> get articles => _articles;


}
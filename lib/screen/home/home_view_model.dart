import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/model/article_model.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/model/instructor_model.dart';
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

  List<ClassModel> _classes = [
    ClassModel(
      idClass: 0,
      name: 'Weight Lifting',
      description: 'Weightlifting is the sport of Strength, Power, Speed and Precision. In competition, the lifts are comprised of the Snatch and the Clean & Jerk – both of which are efforts to lift the maximum amount of weight from ground to overhead in two distinct ways. In training, weightlifting and accessory exercises challenge the mind and body to grow strong and powerful through repetition after repetition of the basics.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Offline',
      images: ['assets/weightlifting.png', 'assets/weightlifting1.png', 'assets/weightlifting2.png'],
      instructor: InstructorModel(id: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 1,
      name: 'Body Building',
      description: 'Bodybuilding is a specific and interesting sport that requires determination and strong discipline. What makes bodybuilding so different is that unlike most sports, in bodybuilding, competitors are judged by the way they look, not the way they perform.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Offline',
      images: ['assets/bodybuilding.png', 'assets/bodybuilding1.png', 'assets/bodybuilding2.png'],
      instructor: InstructorModel(id: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 2,
      name: 'Yoga',
      description: 'Yoga is a mind and body practice. Various styles of yoga combine physical postures, breathing techniques, and meditation or relaxation. Yoga is an ancient practice that may have originated in India. It involves movement, meditation, and breathing techniques to promote mental and physical well-being.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Offline',
      images: ['assets/yoga.png', 'assets/yoga1.png', 'assets/yoga2.png'],
      instructor: InstructorModel(id: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 3,
      name: 'Weight Loss',
      description: 'Weight loss is a decrease in body weight resulting from either voluntary (diet, exercise) or involuntary (illness) circumstances. Most instances of weight loss arise due to the loss of body fat, but in cases of extreme or severe weight loss, protein and other substances in the body can also be depleted.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Offline',
      images: ['assets/weightloss.png', 'assets/weightloss1.png', 'assets/weightloss2.png'],
      instructor: InstructorModel(id: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 4,
      name: 'Zumba',
      description: 'A fitness program which is inspired by music and dance, which were earlier just Latin in nature, now it has got all world wide dance forms and music into its fitness regime.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Offline',
      images: ['assets/zumba.png', 'assets/zumba1.png', 'assets/zumba2.png'],
      instructor: InstructorModel(id: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 5,
      name: 'Cardio',
      description: 'Cardio is defined as any type of exercise that gets your heart rate up and keeps it up for a prolonged period of time. Your respiratory system will start working harder as you begin to breathe faster and more deeply.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Offline',
      images: ['assets/cardio.png', 'assets/cardio1.png', 'assets/cardio2.png'],
      instructor: InstructorModel(id: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 0,
      name: 'Weight Lifting',
      description: 'Weightlifting is the sport of Strength, Power, Speed and Precision. In competition, the lifts are comprised of the Snatch and the Clean & Jerk – both of which are efforts to lift the maximum amount of weight from ground to overhead in two distinct ways. In training, weightlifting and accessory exercises challenge the mind and body to grow strong and powerful through repetition after repetition of the basics.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Online',
      images: ['assets/weightlifting.png', 'assets/weightlifting1.png', 'assets/weightlifting2.png'],
      instructor: InstructorModel(id: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 1,
      name: 'Body Building',
      description: 'Bodybuilding is a specific and interesting sport that requires determination and strong discipline. What makes bodybuilding so different is that unlike most sports, in bodybuilding, competitors are judged by the way they look, not the way they perform.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 0,
      type: 'Online',
      images: ['assets/bodybuilding.png', 'assets/bodybuilding1.png', 'assets/bodybuilding2.png'],
      instructor: InstructorModel(id: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 2,
      name: 'Yoga',
      description: 'Yoga is a mind and body practice. Various styles of yoga combine physical postures, breathing techniques, and meditation or relaxation. Yoga is an ancient practice that may have originated in India. It involves movement, meditation, and breathing techniques to promote mental and physical well-being.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Online',
      images: ['assets/yoga.png', 'assets/yoga1.png', 'assets/yoga2.png'],
      instructor: InstructorModel(id: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 3,
      name: 'Weight Loss',
      description: 'Weight loss is a decrease in body weight resulting from either voluntary (diet, exercise) or involuntary (illness) circumstances. Most instances of weight loss arise due to the loss of body fat, but in cases of extreme or severe weight loss, protein and other substances in the body can also be depleted.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Online',
      images: ['assets/weightloss.png', 'assets/weightloss1.png', 'assets/weightloss2.png'],
      instructor: InstructorModel(id: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 4,
      name: 'Zumba',
      description: 'A fitness program which is inspired by music and dance, which were earlier just Latin in nature, now it has got all world wide dance forms and music into its fitness regime.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Online',
      images: ['assets/zumba.png', 'assets/zumba1.png', 'assets/zumba2.png'],
      instructor: InstructorModel(id: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 5,
      name: 'Cardio',
      description: 'Cardio is defined as any type of exercise that gets your heart rate up and keeps it up for a prolonged period of time. Your respiratory system will start working harder as you begin to breathe faster and more deeply.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Online',
      images: ['assets/cardio.png', 'assets/cardio1.png', 'assets/cardio2.png'],
      instructor: InstructorModel(id: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
  ];

  List<ClassModel> get classes => _classes;

  Future<List<ClassModel>?> getInitData() async {
    changeState(HomeViewState.loading);

    try{
      // _classes = await MainAPI().getAllClass();
      changeState(HomeViewState.none);      
    }
    catch(e){
      if(e is DioError){
        Fluttertoast.showToast(msg: e.toString());
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
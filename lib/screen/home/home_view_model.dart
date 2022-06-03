import 'package:flutter/cupertino.dart';
import 'package:gym_membership_apps/model/article_model.dart';
import 'package:gym_membership_apps/model/home_item_model.dart';

class HomeViewModel with ChangeNotifier{
  final List<HomeItemModel> _homeItem = [
    HomeItemModel(
      image: 'assets/weightlifting.png', 
      className: 'Weight Lifting'
    ),
    HomeItemModel(
      image: 'assets/bodybuilding.png', 
      className: 'Body Building'
    ),
    HomeItemModel(
      image: 'assets/yoga.png', 
      className: 'Yoga'
    ),
    HomeItemModel(
      image: 'assets/weightloss.png', 
      className: 'Weight Loss'
    ),
    HomeItemModel(
      image: 'assets/zumba.png', 
      className: 'Zumba'
    ),
    HomeItemModel(
      image: 'assets/cardio.png', 
      className: 'Cardio'
    ),
  ];

  List<HomeItemModel> get homeItem => _homeItem;

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
  ];

  List<ArticleModel> get articles => _articles;


}
import 'package:flutter/cupertino.dart';
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

}
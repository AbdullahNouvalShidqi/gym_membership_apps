import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return WillPopScope(
      onWillPop: ()async{
        if(homeViewModel.selectedPage != 0){
          homeViewModel.changePage(0);
          return false;
        }
        else{
          DateTime now = DateTime.now();
          if((now.difference(currentBackPressTime!) > const Duration(milliseconds: 2000)) && ModalRoute.of(context)!.isFirst){
            currentBackPressTime = now;
            Fluttertoast.showToast(
              msg: 'Press back again to exit'
            );
            return Future.value(false);
          }
          return Future.value(true);
        }
      },
      child: Scaffold(
        body: homeViewModel.pageOption,
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: SvgPicture.asset('assets/home_icon.svg', color: homeViewModel.selectedPage == 0 ? Theme.of(context).primaryColor : Theme.of(context).unselectedWidgetColor,), label: 'Home'),
            BottomNavigationBarItem(icon: SvgPicture.asset('assets/schedule_icon.svg', color: homeViewModel.selectedPage == 1 ? Theme.of(context).primaryColor : Theme.of(context).unselectedWidgetColor,), label: 'Schedule'),
            BottomNavigationBarItem(icon: SvgPicture.asset('assets/profile_icon.svg', color: homeViewModel.selectedPage == 2 ? Theme.of(context).primaryColor : Theme.of(context).unselectedWidgetColor,), label: 'Profile'),
          ],
          onTap: (index){
            homeViewModel.changePage(index);
          },
          currentIndex: homeViewModel.selectedPage,
        ),
      ),
    );
  }
}
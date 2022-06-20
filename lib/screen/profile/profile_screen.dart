import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/detail/detail_screen.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_card.dart';
import 'package:gym_membership_apps/utilitites/empty_list_view.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

enum ScrollStatus{detached, attached}

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profileScreen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  ScrollStatus _scrollStatus = ScrollStatus.detached;
  final _listviewController = ScrollController();
  final _singleListController = ScrollController();
  bool isDown = false;

  @override
  void initState() {
    _listviewController.addListener(_whenToAnimate);
    super.initState();
  }

  void _whenToAnimate(){
    if(_listviewController.position.userScrollDirection == ScrollDirection.reverse && _singleListController.offset == _singleListController.position.minScrollExtent){
      _singleListController.animateTo(_singleListController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.linear);
      isDown = true;
    }
    if(_listviewController.position.userScrollDirection == ScrollDirection.forward && _listviewController.offset < _listviewController.position.minScrollExtent){
      if(isDown){
        _singleListController.animateTo(_singleListController.position.minScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.linear);
        isDown = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {    
    return Consumer2<ScheduleViewModel, ProfileViewModel>(
      builder: (context, scheduleViewModel, profileViewModel, _) {
        final myAccountSelected = profileViewModel.myAccountSelected;
        final progressSelected = profileViewModel.progressSelected;
        return Scaffold(
          body: SingleChildScrollView(
            controller: _singleListController,
            physics: const NeverScrollableScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  MainProfile(profileViewModel: profileViewModel),
                  const SizedBox(height: 30,),
                  TabButton(
                    myAccountSelected: myAccountSelected,
                    progressSelected: progressSelected,
                    listviewController: _listviewController,
                    singleListController: _singleListController,
                    myAccountOnTap: myAccountOnTap(profileViewModel: profileViewModel),
                    progressOnTap: progressOnTap(profileViewModel: profileViewModel, scheduleViewModel: scheduleViewModel),
                  ),
                  const SizedBox(height: 15),
                  ItemsToReturn(
                    myAccountSelected: myAccountSelected,
                    listviewController: _listviewController,
                    mounted: mounted,
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  void Function() myAccountOnTap({required ProfileViewModel profileViewModel}){
    return (){
      _singleListController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.linear);
      if(_scrollStatus == ScrollStatus.attached){
        _scrollStatus = ScrollStatus.detached;
      }
      profileViewModel.myAccountButtonOnTap();
    };
  }

  void Function() progressOnTap({required ProfileViewModel profileViewModel, required ScheduleViewModel scheduleViewModel}){
    return (){
      if(_scrollStatus == ScrollStatus.attached && scheduleViewModel.listSchedule.isNotEmpty){
        _listviewController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
        _singleListController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }
      _scrollStatus = ScrollStatus.attached;
      profileViewModel.progressButtonOnTap();
    };
  }
}

class MainProfile extends StatelessWidget {
  const MainProfile({Key? key, required this.profileViewModel}) : super(key: key);
  final ProfileViewModel profileViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Center(child: Text('Profile', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),),)
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: CircleAvatar(
            radius: 40,
            child: Image.asset('assets/profile.png'),
          ),
        ),
        const SizedBox(height: 15,),
        Text(profileViewModel.user.username, style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700),),
      ],
    );
  }
}

class TabButton extends StatelessWidget {
  const TabButton({
    Key? key,
    required this.myAccountSelected,
    required this.progressSelected,
    required this.singleListController,
    required this.listviewController,
    required this.myAccountOnTap,
    required this.progressOnTap
  }) : super(key: key);
  final bool myAccountSelected;
  final bool progressSelected;
  final ScrollController singleListController;
  final ScrollController listviewController;
  final void Function() myAccountOnTap;
  final void Function() progressOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: myAccountOnTap,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(myAccountSelected ? Colors.white : null),
            side: MaterialStateProperty.all(BorderSide(color: Utilities.myTheme.primaryColor))
          ),
          child: Text('My Account', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: myAccountSelected ? Utilities.myTheme.primaryColor : null),)
        ),
        const SizedBox(width: 10,),
        ElevatedButton(
          onPressed: progressOnTap,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(progressSelected ? Colors.white : null),
            side: MaterialStateProperty.all(BorderSide(color: Utilities.myTheme.primaryColor))
          ),
          child: Text('Progress', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: progressSelected ? Utilities.myTheme.primaryColor : null),)
        ),
      ],
    );
  }
}

class ItemsToReturn extends StatelessWidget {
  const ItemsToReturn({Key? key, required this.myAccountSelected, required this.listviewController, required this.mounted}) : super(key: key);
  final bool myAccountSelected;
  final ScrollController listviewController;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return Consumer3<ScheduleViewModel, HomeViewModel, ProfileViewModel>(
      builder: (context, scheduleViewModel, homeViewModel, profileViewModel, _){
        if(myAccountSelected){
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profileViewModel.myAccountItems.length,
              itemBuilder: (context, i){
                return Column(
                  children: [
                    if(i < 6) ...[
                      InkWell(
                        onTap: listTileOntap(context: context, i: i, homeViewModel: homeViewModel, profileViewModel: profileViewModel, scheduleViewModel: scheduleViewModel, mounted: mounted),
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              profileViewModel.myAccountItems[i]['icon']!,
                              const SizedBox(width: 10,),
                              profileViewModel.myAccountItems[i]['title']!,
                            ],
                          )
                        ),
                      ),
                      Divider(height: 0, color: Utilities.myTheme.primaryColor,),
                    ],
                    
                    if(i==6) ...[
                      const SizedBox(height: 20,),
                      InkWell(
                        onTap: listTileOntap(context: context, i: i, homeViewModel: homeViewModel, profileViewModel: profileViewModel, scheduleViewModel: scheduleViewModel, mounted: mounted),
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              profileViewModel.myAccountItems[i]['icon']!,
                              const SizedBox(width: 10,),
                              profileViewModel.myAccountItems[i]['title']!,
                            ],
                          )
                        ),
                      ),
                      Divider(height: 0, color: Utilities.myTheme.primaryColor,) 
                    ],
                  ],
                );
              }
            ),
          );
        }
        if(scheduleViewModel.listSchedule.isEmpty){
          return EmptyListView(forProgress: true, svgAssetLink: 'assets/icons/empty_list.svg', emptyListViewFor: EmptyListViewFor.progress, onRefresh: scheduleViewModel.refreshData,);
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height - 150,
          child: Center(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              controller: listviewController,
              itemCount: scheduleViewModel.listSchedule.length,
              itemBuilder: (context, i){
                return InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, DetailScreen.routeName, arguments: scheduleViewModel.listSchedule[i]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: CostumCard(classModel: scheduleViewModel.listSchedule[i], whichScreen: CostumCardFor.profileScreen)
                  ),
                );
              }
            ),
          ),
        );  
      }
    );
  }
  
   Future<void> Function() listTileOntap({
    required BuildContext context, 
    required int i, 
    required ProfileViewModel profileViewModel,
    required HomeViewModel homeViewModel,
    required ScheduleViewModel scheduleViewModel,
    required bool mounted
  }){
    return profileViewModel.onTap(
      context: context,
      i: i,
      scheduleViewModel: scheduleViewModel,
      profileViewModel: profileViewModel,
      homeViewModel: homeViewModel,
      mounted: mounted
    );
  }
}
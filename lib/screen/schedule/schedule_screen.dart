import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/detail/detail_screen.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_card.dart';
import 'package:gym_membership_apps/utilitites/costum_error_screen.dart';
import 'package:gym_membership_apps/utilitites/empty_list_view.dart';
import 'package:gym_membership_apps/utilitites/listview_shimmer_loading.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  static String routeName = '/schedule';
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
  int _currentIndex = 0;

  @override
  void initState() {
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('My Schedules', style: Utilities.appBarTextStyle),
        centerTitle: true,
      ),
      body: Center(
        child: Consumer<ScheduleViewModel>(
          builder: (context, scheduleViewModel, _) {
            final isLoading = scheduleViewModel.state == ScheduleViewState.loading;
            final isError = scheduleViewModel.state == ScheduleViewState.error;
            List<ClassModel> allItem = scheduleViewModel.tempSchedules;
            
            if(isError){
              return CostumErrorScreen(
                onPressed: ()async{
                  await scheduleViewModel.refreshData();
                }
              );
            }
            else if(isLoading){
              return const ListViewShimmerLoading(shimmeringLoadingFor: ShimmeringLoadingFor.scheduleScreen,);
            }
            else if(allItem.isEmpty){
              return EmptyListView(svgAssetLink: 'assets/icons/empty_list.svg', emptyListViewFor: EmptyListViewFor.schedule, onRefresh: scheduleViewModel.refreshData, controller: scheduleViewModel.scheduleListController,);
            }

            return RefreshIndicator(
              key: const Key('scheduleRefresh'),
              onRefresh: scheduleViewModel.refreshData,
              child: Column(
                children: [
                  const SizedBox(height: 5,),
                  SizedBox(
                    height: 35,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15.5),
                      scrollDirection: Axis.horizontal,
                      itemCount: scheduleViewModel.buttonsData.length,
                      itemBuilder: (context, i){
                        return CostumSortingButton(
                          icon: scheduleViewModel.buttonsData[i]['icon'],
                          name: scheduleViewModel.buttonsData[i]['name']!,
                          currentIndex: _currentIndex,
                          i: i,
                          onTap: sortingButtonOnTap(allItem: allItem, i: i, scheduleViewModel: scheduleViewModel),
                        );
                      }
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Expanded(
                    child: FadeTransition(
                      opacity: Tween(begin: 0.8, end: 1.0).animate(_animationController),
                      child: ScaleTransition(
                        scale: Tween(begin: 0.9, end: 1.0).animate(_animationController),
                        child: Scrollbar(
                          controller: scheduleViewModel.scheduleListController,
                          child: ListView.builder(
                            controller: scheduleViewModel.scheduleListController,
                            physics: isLoading ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                            itemCount: isLoading ? 8 : scheduleViewModel.listSchedule.length,
                            itemBuilder: (context, i){
                              return InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, DetailScreen.routeName, arguments: allItem[i]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: CostumCard(classModel: allItem[i], whichScreen: CostumCardFor.scheduleScreen),
                                ),
                              );
                            }
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  void Function() sortingButtonOnTap({required int i, required List<ClassModel> allItem, required ScheduleViewModel scheduleViewModel}){
    return (){
      if(_currentIndex != i){
        setState(() {
          _currentIndex = i;
        });

        _animationController.reverse().then(
          (value) => checkSchedules(allItem: allItem, currentIndex: _currentIndex, scheduleViewModel: scheduleViewModel)
        ).then(
          (value) => 
          _animationController.forward()
        );
      }
    };
  }

  void checkSchedules({required List<ClassModel> allItem, required int currentIndex, required ScheduleViewModel scheduleViewModel}){
    if(currentIndex == 0){
      scheduleViewModel.resetSort();
    }
    if(currentIndex == 1){
      allItem.sort((a, b) => a.endAt.compareTo(b.endAt),);
    }
    if(currentIndex == 2){
      allItem.sort((a, b) => a.startAt.compareTo(b.startAt),);
    }
    if(currentIndex == 3){
      allItem.sort((a, b) => b.name.compareTo(a.name),);
    }
    setState(() {
      
    });
  }
}

class CostumSortingButton extends StatelessWidget {
  const CostumSortingButton({Key? key,
    required this.currentIndex,
    required this.i,
    this.icon,
    required this.name,
    required this.onTap
    
  }) : super(key: key);
  final int currentIndex;
  final int i;
  final String? icon;
  final String name;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.5),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: i == 0 ? 43 : 62,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: currentIndex == i ? Utilities.primaryColor : Utilities.myWhiteColor,
            border: Border.all(color: Utilities.primaryColor)
          ),
          child: icon == null ? Text(name, style: Utilities.costumSortingButtonStyle(i == currentIndex)) :
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon!, color: i == currentIndex ? Utilities.myWhiteColor : Utilities.primaryColor,),
              const SizedBox(width: 5,),
              Text(name, style: Utilities.costumSortingButtonStyle(i == currentIndex))
            ],
          ),
        ),
      ),
    );
  }
}
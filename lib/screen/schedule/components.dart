import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_membership_apps/model/detail_route_model.dart';
import 'package:gym_membership_apps/screen/detail/detail_screen.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_card.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class CostumSortingButtonsBuilder extends StatelessWidget {
  const CostumSortingButtonsBuilder({Key? key, required this.animationController}) : super(key: key);
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final scheduleViewModel = context.watch<ScheduleViewModel>();
    return SizedBox(
      height: 35,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15.5),
        scrollDirection: Axis.horizontal,
        itemCount: scheduleViewModel.buttonsData.length,
        itemBuilder: (context, i) {
          return CostumSortingButton(
            i: i,
            animationController: animationController,
            icon: scheduleViewModel.buttonsData[i]['icon'],
            name: scheduleViewModel.buttonsData[i]['name']!,
          );
        },
      ),
    );
  }
}

class CostumSortingButton extends StatelessWidget {
  const CostumSortingButton({
    Key? key,
    required this.i,
    required this.animationController,
    this.icon,
    required this.name,
  }) : super(key: key);
  final int i;
  final AnimationController animationController;
  final String? icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleViewModel>(
      builder: (context, scheduleViewModel, _) {
        final currentIndex = scheduleViewModel.currentIndex;
        return Padding(
          padding: const EdgeInsets.only(right: 4.5),
          child: GestureDetector(
            onTap: () {
              scheduleViewModel.sortingButtonOnTap(i: i, animationController: animationController);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: i == 0 ? 43 : 62,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: currentIndex == i ? Utilities.primaryColor : Utilities.myWhiteColor,
                border: Border.all(color: Utilities.primaryColor),
              ),
              child: icon == null
                  ? Text(name, style: Utilities.costumSortingButtonStyle(i == currentIndex))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          icon!,
                          color: i == currentIndex ? Utilities.myWhiteColor : Utilities.primaryColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(name, style: Utilities.costumSortingButtonStyle(i == currentIndex))
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}

class CostumScheduleListCard extends StatelessWidget {
  const CostumScheduleListCard({Key? key, required this.animationController}) : super(key: key);
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Consumer2<ScheduleViewModel, HomeViewModel>(
      builder: (context, scheduleViewModel, homeViewModel, _) {
        final isLoading = scheduleViewModel.state == ScheduleViewState.loading;
        final allItem = scheduleViewModel.tempSchedules;
        return Expanded(
          child: FadeTransition(
            opacity: Tween(begin: 0.8, end: 1.0).animate(animationController),
            child: ScaleTransition(
              scale: Tween(begin: 0.9, end: 1.0).animate(animationController),
              child: Scrollbar(
                controller: scheduleViewModel.scheduleListController,
                child: ListView.builder(
                  controller: scheduleViewModel.scheduleListController,
                  physics: isLoading
                      ? const NeverScrollableScrollPhysics()
                      : const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                  itemCount: isLoading ? 8 : scheduleViewModel.listSchedule.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailScreen.routeName,
                          arguments: DetailRouteModel(
                            homeClassModel: homeViewModel.classes.firstWhere(
                              (element) => element.name == allItem[i].name,
                            ),
                            type: allItem[i].type,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: CostumCard(
                            classModel: allItem[i],
                            bookedClass: scheduleViewModel.listBookedClasses[i],
                            whichScreen: CostumCardFor.scheduleScreen),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

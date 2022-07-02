import 'package:flutter/material.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/available_class/available_class_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_card.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_empty_list_view.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CostumTabBar extends StatelessWidget {
  const CostumTabBar({
    Key? key,
    required this.tabController,
    required this.item,
  }) : super(key: key);
  final TabController tabController;
  final ClassModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
      child: Container(
        height: 64,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [BoxShadow(blurRadius: 8, color: Color.fromARGB(255, 230, 230, 230))],
        ),
        child: TabBar(
          controller: tabController,
          indicatorWeight: 0,
          indicator: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Utilities.primaryColor),
          indicatorPadding: const EdgeInsets.all(10),
          isScrollable: false,
          unselectedLabelColor: const Color.fromRGBO(112, 112, 112, 1),
          labelColor: Utilities.myWhiteColor,
          labelPadding: const EdgeInsets.symmetric(horizontal: 10),
          tabs: [
            for (var i = 0; i < 7; i++) ...[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE').format(DateTime.now().add(Duration(days: i))),
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    DateFormat('d').format(DateTime.now().add(Duration(days: i))),
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class CostumTabBarView extends StatelessWidget {
  const CostumTabBarView({Key? key, required this.tabController, required this.classes}) : super(key: key);
  final TabController tabController;
  final List<ClassModel> classes;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: [
          for (var i = 0; i < 7; i++) ...[
            CostumListView(
              availableClasses: classes
                  .where(
                    (element) => element.startAt.day == DateTime.now().add(Duration(days: i)).day,
                  )
                  .toList(),
            ),
          ]
        ],
      ),
    );
  }
}

class CostumListView extends StatelessWidget {
  const CostumListView({Key? key, required this.availableClasses}) : super(key: key);
  final List<ClassModel> availableClasses;

  @override
  Widget build(BuildContext context) {
    final availableClassViewModel = context.watch<AvailableClassViewModel>();

    if (availableClasses.isEmpty) {
      return CostumEmptyListView(
        svgAssetLink: 'assets/icons/empty_class.svg',
        title: 'Ooops, class not yet available',
        emptyListViewFor: EmptyListViewFor.available,
        onRefresh: availableClassViewModel.refreshData,
      );
    }
    return RefreshIndicator(
      onRefresh: availableClassViewModel.refreshData,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 15),
        itemCount: availableClasses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: CostumCard(classModel: availableClasses[index], whichScreen: CostumCardFor.availableClassScreen),
          );
        },
      ),
    );
  }
}

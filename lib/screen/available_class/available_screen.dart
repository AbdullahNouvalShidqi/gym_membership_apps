import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/available_class/available_class_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_error_screen.dart';
import 'package:gym_membership_apps/utilitites/shimmer/listview_shimmer_loading.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

import 'components.dart';

class AvailableClassScreen extends StatefulWidget {
  static String routeName = '/availableClass';
  const AvailableClassScreen({Key? key}) : super(key: key);

  @override
  State<AvailableClassScreen> createState() => _AvailableClassScreenState();
}

class _AvailableClassScreenState extends State<AvailableClassScreen> with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 7, vsync: this);
  late ClassModel item;
  Timer? _timer;

  @override
  void dispose() {
    _tabController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final availableClassViewModel = Provider.of<AvailableClassViewModel>(context, listen: false);

      await availableClassViewModel.getAvailableClasses(item: item);
      _startTimer();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    item = ModalRoute.of(context)!.settings.arguments as ClassModel;
    final availableClassViewModel = context.watch<AvailableClassViewModel>();
    final classes = availableClassViewModel.availableClasses;
    final isLoading = availableClassViewModel.state == AvailableClassState.loading;
    final isError = availableClassViewModel.state == AvailableClassState.error;

    return WillPopScope(
      onWillPop: availableClassViewModel.onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Builder(
            builder: (context) {
              if (isLoading) {
                return const ListViewShimmerLoading(shimmeringLoadingFor: ShimmeringLoadingFor.availableScreen);
              }
              if (isError) {
                return CostumErrorScreen(
                  onPressed: () async {
                    await availableClassViewModel.getAvailableClasses(item: item);
                  },
                );
              }
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      title: Text('${item.type} ${item.name} Class', style: Utilities.appBarTextStyle),
                      centerTitle: true,
                    )
                  ];
                },
                body: Column(
                  children: [
                    CostumTabBar(tabController: _tabController, item: item),
                    CostumTabBarView(tabController: _tabController, classes: classes)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

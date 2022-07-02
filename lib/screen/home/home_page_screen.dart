import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_error_screen.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_home_card.dart';
import 'package:gym_membership_apps/utilitites/shimmer/home_shimmer_loading.dart';
import 'package:provider/provider.dart';

import 'components.dart';

class HomePageScreen extends StatefulWidget {
  static String routeName = '/homePageScreen';
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomeViewModel>(context, listen: false).getInitData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, _) {
          final isError = homeViewModel.state == HomeViewState.error;
          final isLoading = homeViewModel.state == HomeViewState.loading;
          final classes = homeViewModel.classes;

          if (isError) {
            return CostumErrorScreen(
              onPressed: homeViewModel.getInitData,
            );
          }

          if (isLoading) {
            return const HomeShimmerLoading();
          }

          return RefreshIndicator(
            onRefresh: homeViewModel.refreshData,
            child: SingleChildScrollView(
              controller: homeViewModel.homeScrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CostumMainAvatarAndDetail(),
                  CostumHomeCard(homeClassModel: classes, type: 'Online', height: 164, width: 125),
                  const SizedBox(height: 20),
                  CostumHomeCard(homeClassModel: classes.reversed.toList(), type: 'Offline', height: 164, width: 125),
                  const SizedBox(height: 20),
                  const TipsListView()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

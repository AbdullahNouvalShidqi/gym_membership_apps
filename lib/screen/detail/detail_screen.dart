import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/model/detail_route_model.dart';
import 'package:gym_membership_apps/screen/detail/detail_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_error_screen.dart';
import 'package:gym_membership_apps/utilitites/empty_list_view.dart';
import 'package:gym_membership_apps/utilitites/shimmer/detail_shimmer_loading.dart';
import 'package:provider/provider.dart';

import 'components.dart';

class DetailScreen extends StatefulWidget {
  static String routeName = '/detail';
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ClassModel? classModel;
  late DetailRouteModel data;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final detailViewModel = Provider.of<DetailViewModel>(context, listen: false);
      classModel = await detailViewModel.getDetail(item: data.homeClassModel, type: data.type);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as DetailRouteModel;

    return Scaffold(
      body: Consumer<DetailViewModel>(
        builder: (context, detailViewModel, _) {
          final isLoading = detailViewModel.state == DetailState.loading;
          final isError = detailViewModel.state == DetailState.error;

          if (isLoading) {
            return const DetailShimmerLoading();
          }
          if (isError) {
            return CostumErrorScreen(
              onPressed: () async {
                classModel = await detailViewModel.getDetail(item: data.homeClassModel, type: data.type);
                if (classModel == null) {
                  Fluttertoast.showToast(msg: 'No data found');
                }
              },
            );
          }
          if (classModel == null) {
            return EmptyListView(
              title: 'Class detail not found, pull to refresh',
              svgAssetLink: 'assets/icons/empty_class.svg',
              emptyListViewFor: EmptyListViewFor.detail,
              onRefresh: () async {
                classModel = await detailViewModel.refreshDetail(item: data.homeClassModel, type: data.type);
                if (classModel == null) {
                  Fluttertoast.showToast(msg: 'No data found');
                }
              },
            );
          }
          return WillPopScope(
            onWillPop: detailViewModel.onWillPop,
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          MainCarousel(images: classModel!.images),
                          Positioned.fill(
                            bottom: 17,
                            child: CarouselIndicator(images: classModel!.images),
                          )
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 15),
                                    MainTitleStatus(className: classModel!.name, type: classModel!.type),
                                    const SizedBox(height: 5),
                                    Price(price: classModel!.price),
                                    const SizedBox(height: 10),
                                    InstructorName(item: classModel!),
                                    const SizedBox(height: 5),
                                    GymLocation(location: classModel!.location),
                                    const SizedBox(height: 10),
                                    ClassDetail(item: classModel!),
                                  ],
                                ),
                              ),
                            ),
                            SeeAvalableClassButton(item: classModel!),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const CostumAppBar()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum EmptyListViewFor { schedule, available, progress, detail }

class CostumEmptyListView extends StatelessWidget {
  const CostumEmptyListView({
    Key? key,
    this.forProgress = false,
    this.title,
    required this.svgAssetLink,
    required this.emptyListViewFor,
    required this.onRefresh,
    this.controller,
  }) : super(key: key);
  final bool forProgress;
  final String? title;
  final Future<void> Function() onRefresh;
  final String svgAssetLink;
  final EmptyListViewFor emptyListViewFor;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    late double height;
    if (emptyListViewFor == EmptyListViewFor.progress) {
      height = MediaQuery.of(context).size.height - 335;
    } else if (emptyListViewFor == EmptyListViewFor.schedule) {
      height = MediaQuery.of(context).size.height - 135;
    } else if (emptyListViewFor == EmptyListViewFor.available) {
      height = MediaQuery.of(context).size.height - 210;
    } else if (emptyListViewFor == EmptyListViewFor.detail) {
      height = MediaQuery.of(context).size.height - 80;
    }

    return RefreshIndicator(
      key: const Key('scheduleRefresh'),
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        controller: controller,
        child: SizedBox(
          height: height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(svgAssetLink),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  title ?? 'Ooops, your ${forProgress ? 'progress' : 'schedule'} is still empty',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

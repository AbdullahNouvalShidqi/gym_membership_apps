import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

enum EmptyListViewFor{schedule, available, progress}

class EmptyListView extends StatelessWidget {
  const EmptyListView({Key? key, this.forProgress = false, this.title, required this.svgAssetLink, required this.emptyListViewFor, required this.onRefresh, this.controller}) : super(key: key);
  final bool forProgress;
  final String? title;
  final Future<void> Function() onRefresh;
  final String svgAssetLink;
  final EmptyListViewFor emptyListViewFor;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        late double height;
        if(emptyListViewFor == EmptyListViewFor.progress){
          height = MediaQuery.of(context).size.height - 335;
        }
        if(emptyListViewFor == EmptyListViewFor.schedule){
          height = MediaQuery.of(context).size.height - 135;
        }
        if (emptyListViewFor == EmptyListViewFor.available){
          height = height = MediaQuery.of(context).size.height - 210;
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
                    const SizedBox(height: 30,),
                    Text(title ?? 'Ooops, your ${forProgress ? 'progress' : 'schedule'} is still empity', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700))
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/faq/faq_view_model.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

import 'components.dart';

class FaqScreen extends StatefulWidget {
  static String routeName = '/faq';
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> with TickerProviderStateMixin {
  late final List<ScrollController> _scrollControllers = [];
  late final List<AnimationController> _animationControllers = [];
  late final List<bool> _isShown = [];

  @override
  void initState() {
    super.initState();
    int length = Provider.of<FaqViewModel>(context, listen: false).mainData.length;
    for (var i = 0; i < length; i++) {
      _scrollControllers.add(ScrollController());
      _animationControllers.add(AnimationController(vsync: this, duration: const Duration(milliseconds: 200)));
      _isShown.add(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var i = 0; i < _scrollControllers.length; i++) {
      _scrollControllers[i].dispose();
      _animationControllers[i].dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final faqScreenModel = context.watch<FaqViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ', style: Utilities.appBarTextStyle),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
        child: ListView.builder(
          itemCount: faqScreenModel.mainData.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                CostumMainCard(
                  i: i,
                  titleWidget: faqScreenModel.mainData[i]['title']!,
                  animationControllers: _animationControllers,
                  onTap: () {
                    onTap(i);
                  },
                ),
                CostumSubCard(
                  i: i,
                  faqViewModel: faqScreenModel,
                  animationControllers: _animationControllers,
                  scrollControllers: _scrollControllers,
                  isShown: _isShown,
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void onTap(int i) {
    setState(() {
      _isShown[i] = !_isShown[i];
    });
    if (_animationControllers[i].status == AnimationStatus.forward) {
      _animationControllers[i].reverse();
    } else if (_animationControllers[i].status == AnimationStatus.reverse) {
      _animationControllers[i].forward();
    } else {
      _animationControllers[i].isCompleted ? _animationControllers[i].reverse() : _animationControllers[i].forward();
    }
  }
}

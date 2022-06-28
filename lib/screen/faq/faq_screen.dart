import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/faq/faq_view_model.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

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
                  onTap: onTap(i),
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

  void Function() onTap(int i) {
    return () {
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
    };
  }
}

class CostumMainCard extends StatelessWidget {
  const CostumMainCard({
    Key? key,
    required this.i,
    required this.titleWidget,
    required this.animationControllers,
    required this.onTap,
  }) : super(key: key);
  final int i;
  final Widget titleWidget;
  final List<AnimationController> animationControllers;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(blurRadius: 8, color: Color.fromARGB(255, 240, 240, 240)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              titleWidget,
              RotationTransition(
                turns: Tween(begin: 0.0, end: 0.25).animate(animationControllers[i]),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Utilities.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CostumSubCard extends StatelessWidget {
  const CostumSubCard({
    Key? key,
    required this.i,
    required this.isShown,
    required this.animationControllers,
    required this.scrollControllers,
    required this.faqViewModel,
  }) : super(key: key);
  final int i;
  final List<bool> isShown;
  final List<AnimationController> animationControllers;
  final List<ScrollController> scrollControllers;
  final FaqViewModel faqViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isShown[i] ? 10 : 5),
      child: SlideTransition(
        position: Tween(begin: const Offset(0.0, -0.2), end: Offset.zero).animate(animationControllers[i]),
        child: FadeTransition(
          opacity: animationControllers[i],
          child: AnimatedContainer(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 200),
            width: MediaQuery.of(context).size.width,
            height: isShown[i] ? 60 : 0,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(232, 232, 232, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Scrollbar(
                thumbVisibility: true,
                controller: scrollControllers[i],
                child: SingleChildScrollView(
                  controller: scrollControllers[i],
                  child: faqViewModel.mainData[i]['value'],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

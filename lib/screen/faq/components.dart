import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/faq/faq_view_model.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

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
            height: isShown[i] ? faqViewModel.mainData[i]['height'] ?? 80 : 0,
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

import 'package:flutter/material.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

import 'components.dart';

class PaymentInstructionScreen extends StatefulWidget {
  static String routeName = '/paymentInstruction';
  const PaymentInstructionScreen({Key? key}) : super(key: key);

  @override
  State<PaymentInstructionScreen> createState() => _PaymentInstructionScreenState();
}

class _PaymentInstructionScreenState extends State<PaymentInstructionScreen> with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  final _scrollController = ScrollController();
  bool _isShown = false;

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as ClassModel?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Instruction', style: Utilities.appBarTextStyle),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 15),
            PriceContainer(price: item?.price),
            const SizedBox(height: 15),
            const PaymentDetailContainer(),
            const SizedBox(height: 15),
            CostumMainCard(animationController: _animationController, onTap: instructionOnTap),
            CostumSubCard(
              animationController: _animationController,
              scrollController: _scrollController,
              isShown: _isShown,
            ),
            const Expanded(child: SizedBox()),
            item == null ? const SizedBox() : CostumButtons(item: item),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  void instructionOnTap() {
    setState(() {
      _isShown = !_isShown;
    });
    if (_animationController.status == AnimationStatus.forward) {
      _animationController.reverse();
    } else if (_animationController.status == AnimationStatus.reverse) {
      _animationController.forward();
    } else {
      _animationController.isCompleted ? _animationController.reverse() : _animationController.forward();
    }
  }
}

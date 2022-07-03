import 'package:flutter/material.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class FaqViewModel with ChangeNotifier {
  final List<Map<String, dynamic>> _mainData = [
    {
      'title': const Text('What is A-A Gym?', style: Utilities.faqTitleStyle),
      'value': RichText(
        text: const TextSpan(
          text: 'A-A Gym in an appication that provides you with many features to support your healty lifestyle.',
          style: Utilities.faqSubTitleStyle,
        ),
      ),
      'height': 60.0
    },
    {
      'title': const Text('Is the trainer professional?', style: Utilities.faqTitleStyle),
      'value': RichText(
        text: const TextSpan(
          text:
              'All trainers in the A-A gym are professional trainers in their fields because we want all those who attend the A-A gym class to be able to apply the right exercise according to their goals.',
          style: Utilities.faqSubTitleStyle,
        ),
      ),
    },
    {
      'title': const Text('How to book?', style: Utilities.faqTitleStyle),
      'value': RichText(
        text: const TextSpan(
          text:
              'You can choose a gym class first on the homepage, after that you can choose the available gym class schedule and then you can book a class and make payments at the gym.',
          style: Utilities.faqSubTitleStyle,
        ),
      ),
    },
    {
      'title': const Text('How to joined class from home?', style: Utilities.faqTitleStyle),
      'value': RichText(
        text: const TextSpan(
          text:
              'you can choose a gym class online first on the homepage, after that you can choose the available gym class online schedule and then you can book a class and make payments at the gym.',
          style: Utilities.faqSubTitleStyle,
        ),
      ),
    },
  ];

  List<Map<String, dynamic>> get mainData => _mainData;
}

import 'package:flutter/material.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class FaqViewModel with ChangeNotifier{
  final List<Map<String, dynamic>> _mainData = [
    {
      'title' : Text('What is A-A Gym?', style: Utilities.faqTitleStyle,),
      'value' : RichText(
        text: TextSpan(
          text: 'A-A Gym in an appication that provides you with many features to support your healty lifestyle.',
          style: Utilities.faqSubTitleStyle,
        ),
      ),
      'height' : 60.0
    },{
      'title' : Text('Is the trainer professional?', style: Utilities.faqTitleStyle,),
      'value' : RichText(
        text: TextSpan(
          text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Est, lectus sit dictum etiam fringilla faucibus. Duis interdum suscipit mi vitae sagittis, semper a ullamcorper viverra. Sed lacus aliquam diam eget magna tempor, senectus dignissim. Sodales malesuada odio montes, morbi interdum maecenas.',
          style: Utilities.faqSubTitleStyle,
        ),
      ),
      'height' : 100.0
    }
  ];

  List<Map<String, dynamic>> get mainData => _mainData;
    
}
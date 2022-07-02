import 'package:flutter/material.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'components.dart';

class FeedbackScreen extends StatefulWidget {
  static String routeName = '/feedback';
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send us Feedbacks', style: Utilities.appBarTextStyle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('What do you think of the app?', style: TextStyle(fontSize: 12)),
              SizedBox(height: 6),
              RatingStarBar(),
              SizedBox(height: 31),
              Text('What do you think of the app?', style: TextStyle(fontSize: 12)),
              SizedBox(height: 5),
              FeedbackFormField(),
              SizedBox(height: 20),
              SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

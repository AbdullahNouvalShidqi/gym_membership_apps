import 'package:flutter/material.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:intl/intl.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  static String routeName = '/termsAndConditions';
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms and Conditions',
          style: Utilities.appBarTextStyle,
        ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 302,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Utilities.primaryColor),
              ),
              margin: const EdgeInsets.only(top: 10),
              child: const SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    "A-A Gym is Indonesia's leading healthy lifestyle application that provides easy access and solutions for your healthy lifestyle. search, book, order, and be healthier with your healthy life partner.",
                    style: TextStyle(fontSize: 12, color: Color.fromRGBO(112, 112, 112, 1)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 23),
            Text(
              'Last updated: ${DateFormat('MMMM d, y').format(DateTime(2021, 6, 1))}',
              style: const TextStyle(fontSize: 12, color: Color.fromRGBO(153, 153, 153, 1)),
            )
          ],
        ),
      ),
    );
  }
}

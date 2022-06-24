import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/utilitites/costum_button.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class FeedbackScreen extends StatefulWidget {
  static String routeName = '/feedback';
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double _rating = 0;
  final _formKey = GlobalKey<FormState>();
  final _reviewCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _reviewCtrl.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send us Feedbacks', style: Utilities.appBarTextStyle,),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('What do you think of the app?', style: GoogleFonts.roboto(fontSize: 12),),
              const SizedBox(height: 6,),
              RatingStarBar(
                rating: _rating,
                onRatingUpdate: (newRating){
                  _rating = newRating;
                },
              ),
              const SizedBox(height: 31,),
              Text('What do you think of the app?', style: GoogleFonts.roboto(fontSize: 12),),
              const SizedBox(height: 5,),
              FeedbackFormField(
                formKey: _formKey,
                reviewCtrl: _reviewCtrl,
              ),
              const SizedBox(height: 20,),
              SubmitButton(
                formKey: _formKey,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RatingStarBar extends StatelessWidget {
  const RatingStarBar({Key? key, required this.rating, required this.onRatingUpdate}) : super(key: key);
  final double rating;
  final void Function(double) onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemPadding: const EdgeInsets.only(right: 3),
      initialRating: rating,
      itemCount: 5,
      itemBuilder: (context, i){
        return Icon(Icons.star, color: Utilities.primaryColor,);
      },
      onRatingUpdate: onRatingUpdate
    );
  }
}

class FeedbackFormField extends StatelessWidget {
  const FeedbackFormField({Key? key, required this.formKey, required this.reviewCtrl}) : super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController reviewCtrl;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: reviewCtrl,
        decoration: InputDecoration(
          hintText: 'Type your feedback 500 character left',
          hintStyle: GoogleFonts.roboto(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        maxLines: 8,
        maxLength: 500,
        validator: (newValue){
          if(newValue == ' ' || newValue!.contains('  ')){
            return 'Please input your feedback correctly';
          }
          return null;
        },
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key, required this.formKey}) : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return CostumButton(
      onPressed: () async {
        if(!formKey.currentState!.validate())return;
      },
      childText: 'Submit'
    );
  }
}
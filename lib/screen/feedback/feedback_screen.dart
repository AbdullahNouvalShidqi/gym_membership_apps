import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send us Feedbacks', style: Utilities.appBarTextStyle,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('What do you think of the app?', style: GoogleFonts.roboto(fontSize: 12),),
              const SizedBox(height: 6,),
              RatingBar.builder(
                itemPadding: const EdgeInsets.only(right: 3),
                initialRating: _rating,
                itemCount: 5,
                itemBuilder: (context, i){
                  return Icon(Icons.star, color: Utilities.primaryColor,);
                },
                onRatingUpdate: (rating){
                  _rating = rating;
                }
              ),
              const SizedBox(height: 31,),
              Text('What do you think of the app?', style: GoogleFonts.roboto(fontSize: 12),),
              const SizedBox(height: 5,),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _reviewCtrl,
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
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate())return;
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 40))
                ),
                child: Text('Submit', style: GoogleFonts.roboto(fontSize: 16, color: Colors.white),)
              )
            ],
          ),
        ),
      ),
    );
  }
}
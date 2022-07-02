import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gym_membership_apps/screen/feedback/feedback_view_model.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_button.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class RatingStarBar extends StatelessWidget {
  const RatingStarBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feedbackViewModel = context.watch<FeedbackViewModel>();
    return RatingBar.builder(
      itemPadding: const EdgeInsets.only(right: 3),
      initialRating: feedbackViewModel.rating,
      itemCount: 5,
      itemBuilder: (context, i) {
        return const Icon(Icons.star, color: Utilities.primaryColor);
      },
      onRatingUpdate: feedbackViewModel.onRatingUpdate,
    );
  }
}

class FeedbackFormField extends StatelessWidget {
  const FeedbackFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feedbackViewModel = context.watch<FeedbackViewModel>();
    return Form(
      key: feedbackViewModel.formKey,
      child: TextFormField(
        controller: feedbackViewModel.reviewCtrl,
        decoration: InputDecoration(
          hintText: 'Type your feedback 500 character left',
          hintStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        maxLines: 8,
        maxLength: 500,
        validator: (newValue) {
          if (newValue == ' ' || newValue!.contains('  ')) {
            return 'Please input your feedback correctly';
          }
          return null;
        },
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feedbackViewModel = context.watch<FeedbackViewModel>();
    final profileViewModel = context.watch<ProfileViewModel>();
    final isLoading = feedbackViewModel.state == FeedBackState.loading;

    return CostumButton(
      isLoading: isLoading,
      onPressed: () async {
        await feedbackViewModel.sendFeedOnTap(context, profileViewModel: profileViewModel);
      },
      childText: 'Submit',
    );
  }
}

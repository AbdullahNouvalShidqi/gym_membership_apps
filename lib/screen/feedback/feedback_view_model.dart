import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/api/email_js_api.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';

enum FeedBackState { none, loading, error }

class FeedbackViewModel with ChangeNotifier {
  FeedBackState _state = FeedBackState.none;
  FeedBackState get state => _state;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _reviewCtrl = TextEditingController();
  TextEditingController get reviewCtrl => _reviewCtrl;

  double _rating = 0;
  double get rating => _rating;

  void changeState(FeedBackState s) {
    _state = s;
    notifyListeners();
  }

  void onRatingUpdate(double newValue) {
    _rating = newValue;
  }

  Future<void> sendFeedBack({
    required String username,
    required String email,
    required double rating,
    required String feedback,
  }) async {
    changeState(FeedBackState.loading);

    try {
      await EmailJsAPI().sendFeedBack(
        username: username,
        email: email,
        rating: rating.toString(),
        feedback: feedback,
      );
      changeState(FeedBackState.none);
    } catch (e) {
      changeState(FeedBackState.error);
    }
  }

  void Function() sendFeedOnTap({required ProfileViewModel profileViewModel}) {
    final username = profileViewModel.user.username;
    final email = profileViewModel.user.email;
    return () async {
      if (!_formKey.currentState!.validate()) return;

      await sendFeedBack(username: username, email: email, rating: _rating, feedback: _reviewCtrl.text);

      final isError = _state == FeedBackState.error;

      if (isError) {
        Fluttertoast.showToast(msg: 'Failed to send feedback, check your internet connection and try again');
        return;
      }

      Fluttertoast.showToast(msg: 'Feedback has been sent to developer!, thanks for your feedback');
      _rating = 0;
      _reviewCtrl.text = '';
      notifyListeners();
    };
  }
}

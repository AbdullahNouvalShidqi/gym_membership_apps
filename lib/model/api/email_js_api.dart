import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class EmailJsAPI {
  final dio = Dio();
  String url = 'https://api.emailjs.com/api/v1.0/email';

  Future<String> sendOTP({required String email}) async {
    String numbers = '0987654321';
    String otp = '';
    final random = Random();
    for (var i = 0; i < 4; i++) {
      otp += numbers[random.nextInt(numbers.length)];
    }
    await dio.post(
      '$url/send',
      data: jsonEncode({
        'service_id': Utilities.serviceId,
        'template_id': Utilities.otpTemplateId,
        'user_id': Utilities.userId,
        'accessToken': Utilities.accessToken,
        'template_params': {
          'email': email,
          'otp': otp,
          'reply_to': email,
        },
      }),
      options: Options(
        contentType: 'application/json',
      ),
    );
    return otp;
  }

  Future<void> sendFeedBack({
    required String username,
    required String email,
    required String rating,
    required String feedback,
  }) async {
    await dio.post(
      '$url/send',
      data: jsonEncode({
        'service_id': Utilities.serviceId,
        'template_id': Utilities.feedbackTemplateId,
        'user_id': Utilities.userId,
        'accessToken': Utilities.accessToken,
        'template_params': {
          'username': username,
          'email_address': email,
          'rating': rating,
          'feedback': feedback,
        },
      }),
    );
  }
}

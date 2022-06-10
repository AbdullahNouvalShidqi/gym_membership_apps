import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';

class EmailJsAPI {
  static Future<String> sendOTP({
    required String email, 
  }) async {
    Response<dynamic>? response;
    final dio = Dio();
    String numbers = '0987654321';
    String otp = '';
    final random = Random();
    for(var i = 0; i < 4; i++){
      otp += numbers[random.nextInt(numbers.length)];
    }
    response = await dio.post(
      'https://api.emailjs.com/api/v1.0/email/send',
      data: jsonEncode({
        'service_id' : 'service_vgdtrkl',
        'template_id': 'template_72lly5x',
        'user_id': 'Vd_KL9xxjmE9t1gSo',
        'accessToken' : 'ujNTh80NEezz01WBrtkWN',
        'template_params' : {
          'email' : email,
          'otp' : otp,
          'reply_to': email
        },
      }),
      options: Options(
        contentType: 'application/json',
      )
    );
    return otp;
  }
}
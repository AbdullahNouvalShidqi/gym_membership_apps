import 'package:dio/dio.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/model/user_model.dart';

class MainAPI {
  final String url = "https://capstone-kelompok-3.herokuapp.com";
  final dio = Dio();

  Future<List<ClassModel>> getAllClass() async {
    final response = await dio.get('$url/class');

    final data = ClassApiModel.fromJson(response.data);

    return data.data;
  }

  Future<List<UserModel>> getAllUser() async {
    final response = await dio.get('$url/users/user');

    final data = UserApiModel.fromJson(response.data);

    return data.data;
  }

  Future<UserModel> signUp({
    required String username,
    required String email,
    required String contact,
    required String password
  }) async {
    final data = UserModel(username: username, email: email, contact: contact, password: password).toJson();

    final response = await dio.post('$url/users/register/user', data: data);

    final returnData = UserModel.fromJson(response.data['data']);

    return returnData;
  }
}
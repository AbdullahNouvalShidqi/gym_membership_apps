import 'package:dio/dio.dart';
import 'package:gym_membership_apps/model/article_model.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/model/home_class_model.dart';
import 'package:gym_membership_apps/model/user_model.dart';

class MainAPI {
  final String url = "https://capstone-kelompok-3.herokuapp.com";
  final String url2 = "https://capstone-project-ec879-default-rtdb.asia-southeast1.firebasedatabase.app";
  final dio = Dio(BaseOptions(
    connectTimeout: 9000,
    receiveTimeout: 9000,
    sendTimeout: 9000,
  ));

  Future<List<ClassModel>> getAllClass({String? type}) async {
    final response = await dio.get('$url/class${type == null ? '' : '/${type.toLowerCase()}'}');

    final data = ClassApiModel.fromJson(response.data);

    return data.data;
  }

  Future<ClassModel?> getClassById({required int id}) async {
    final response = await dio.get('$url/class/$id');

    final Map<String, dynamic>? classData = (response.data as List).firstWhere((element) => element, orElse: () => null);

    ClassModel? data;

    if (classData != null) {
      data = ClassModel.fromJson(classData);
    }

    return data;
  }

  Future<List<HomeClassModel>> getHomeClass() async {
    final response = await dio.get('$url2/class.json');

    final data = (response.data as List).map((e) => HomeClassModel.fromJson(e)).toList();

    return data;
  }

  Future<List<ArticleModel>> getArticles() async {
    final response = await dio.get('$url2/articles.json');

    final data = (response.data as List).map((e) => ArticleModel.fromJson(e)).toList();

    return data;
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
    required String password,
  }) async {
    final data = UserModel(username: username, email: email, contact: contact, password: password).toJson();

    final response = await dio.post('$url/users/register/user', data: data);

    final returnData = UserModel.fromJson(response.data['data']);

    return returnData;
  }
}

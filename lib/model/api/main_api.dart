import 'package:gym_membership_apps/model/article_model.dart';
import 'package:gym_membership_apps/model/book_model.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/model/home_class_model.dart';
import 'package:gym_membership_apps/model/to_book_model.dart';
import 'package:gym_membership_apps/model/user_model.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class MainAPI {
  final String url = "https://capstone-kelompok-3.herokuapp.com";
  final String url2 = "https://capstone-project-ec879-default-rtdb.asia-southeast1.firebasedatabase.app";
  final dio = Utilities.dio;

  Future<List<ClassModel>> getAllClass({String? type}) async {
    final response = await dio.get('$url/class${type == null ? '' : '/${type.toLowerCase()}'}');

    final data = ClassApiModel.fromJson(response.data);

    return data.data;
  }

  Future<ClassModel> getClassById({required int id}) async {
    final response = await dio.get('$url/class/$id');

    final data = (response.data['data'] as List).map((e) => ClassModel.fromJson(e)).first;

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

  Future<void> updatePassword({required int id, required String newPassword}) async {
    await dio.put(
      '$url/users/update/password/$id',
      data: {'password': newPassword},
    );
  }

  Future<UserModel> getUserById({required int id}) async {
    final response = await dio.get('$url/users/$id');

    final data = UserModel.fromJson(response.data['data']);

    return data;
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

  Future<void> bookClass({required int classId, required int idUser}) async {
    final data = ToBookModel(classId: classId, idUser: idUser).toJson();

    await dio.post('$url/booking', data: data);
  }

  Future<List<BookModel>> getSchedulesById({required int id}) async {
    final response = await dio.get('$url/booking/iduser/$id');

    if (response.data['data'] != null) {
      final data = (response.data['data'] as List).map((e) => BookModel.fromJson(e)).toList();
      return data;
    }

    return [];
  }
}

class UserApiModel {
  bool success;
  String message;
  List<UserModel> data;

  UserApiModel({required this.success, required this.message, required this.data});

  UserApiModel.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        message = json['message'],
        data = (json['data'] as List).map((e) => UserModel.fromJson(e)).toList();
}

class UserModel {
  int? id;
  String username;
  String email;
  String contact;
  String password;

  UserModel({this.id, required this.username, required this.email, required this.contact, required this.password});

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'].toString(),
        username = json['username'].toString(),
        contact = json['contact'].toString(),
        password = json['password'].toString();

  toJson() => {
        'username': username,
        'name': username,
        'email': email,
        'contact': contact,
        'password': password,
      };
}

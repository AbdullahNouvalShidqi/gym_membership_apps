class UserModel {
  int idUser;
  String username;
  String email;
  String contact;
  String password;

  UserModel({this.idUser = 0, required this.username, required this.email, required this.contact, required this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    idUser: json['id_user'],
    username: json['username'],
    email: json['email'],
    contact: json['contact'],
    password: json['password']
  );

  toJson() => {
    'id_user' : idUser,
    'username' : username,
    'email': email,
    'contact': contact,
    'password': password
  };
}
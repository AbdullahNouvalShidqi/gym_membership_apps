class UserModel {
  String? username;
  String? emailAddress;
  String? phoneNumber;
  String? password;

  UserModel({this.username, this.emailAddress, this.phoneNumber, this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    username: json['username'],
    emailAddress: json['emailAddress'],
    phoneNumber: json['phoneNumber'],
    password: json['password']
  );

  toJson() => {
    'username' : username,
    'emailAddress': emailAddress,
    'phoneNumber': phoneNumber,
    'password': password
  };
}
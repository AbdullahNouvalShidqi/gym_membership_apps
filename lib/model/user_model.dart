class UserModel {
  String username;
  String emailAddress;
  String phoneNumber;
  String password;

  UserModel({required this.username, required this.emailAddress, required this.phoneNumber, required this.password});

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
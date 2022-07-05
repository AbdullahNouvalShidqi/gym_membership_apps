import 'package:gym_membership_apps/model/instructor_model.dart';

class ClassApiModel {
  bool success;
  String message;
  List<ClassModel> data;

  ClassApiModel({required this.success, required this.message, required this.data});

  ClassApiModel.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        message = json['message'],
        data = (json['data'] as List).map((e) => ClassModel.fromJson(e)).toList();
}

class ClassModel {
  int id;
  String name;
  String description;
  DateTime startAt;
  DateTime endAt;
  int qtyUsers;
  String type;
  int price;
  String location;
  List<String> images;
  InstructorModel instructor;
  String? status;

  ClassModel({
    required this.id,
    required this.name,
    required this.description,
    required this.startAt,
    required this.endAt,
    required this.qtyUsers,
    required this.type,
    required this.price,
    required this.location,
    required this.images,
    required this.instructor,
    this.status,
  });

  ClassModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        startAt = DateTime.parse(json['startAt']),
        endAt = DateTime.parse(json['endAt']),
        qtyUsers = json['qtyUsers'],
        type = json['type'],
        price = json['price'],
        location = json['location'],
        images = [],
        instructor = InstructorModel.fromJson(json['idInstructor']);
}

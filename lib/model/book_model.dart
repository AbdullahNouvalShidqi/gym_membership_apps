import 'package:gym_membership_apps/model/class_model.dart';

class BookModel {
  int id;
  ClassModel bookedClasses;
  bool isBooked;

  BookModel({
    required this.id,
    required this.bookedClasses,
    required this.isBooked,
  });

  BookModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        bookedClasses = ClassModel.fromJson(json['classId']),
        isBooked = json['isBooked'];
}

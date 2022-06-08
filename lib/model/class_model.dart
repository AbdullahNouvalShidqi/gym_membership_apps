import 'package:gym_membership_apps/model/instructor_model.dart';

class ClassModel {
  int idClass;
  String name;
  String description;
  DateTime startAt;
  DateTime endAt;
  int qtyUser;
  String type;
  List<String>? images;
  InstructorModel instructor;

  ClassModel({
    required this.idClass, 
    required this.name, 
    required this.description, 
    required this.startAt, 
    required this.endAt, 
    required this.qtyUser, 
    required this.type,
    this.images,
    required this.instructor
  });

  ClassModel.fromJson(Map<String, dynamic> json)
  : idClass = json['id_class'],
    name = json['name'],
    description = json['description'],
    startAt = DateTime.parse(json['start_at']),
    endAt = DateTime.parse(json['end_at']),
    qtyUser = json['qty_user'],
    type = json['type'],
    instructor = InstructorModel.fromJson(json['instructor'])
  ;
}
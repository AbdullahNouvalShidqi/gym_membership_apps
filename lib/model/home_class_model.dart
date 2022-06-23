import 'instructor_model.dart';

class HomeClassModel{
  String name;
  String description;
  List<String> images;
  InstructorModel instructor;

  HomeClassModel({
    required this.name,
    required this.description,
    required this.images,
    required this.instructor
  });

  HomeClassModel.fromJson(Map<String, dynamic> json)
  :
    name = json['name'],
    description = json['description'],
    images = (json['images'] as List).map((e) => e.toString()).toList(),
    instructor = InstructorModel.fromJson(json['instructor'])
  ;

  toJson() => {
    'name' : name,
    'description' : description,
    'images' : List<dynamic>.from(images.map((e) => e)),
    'instructor' : instructor.toJson(),
  };
}
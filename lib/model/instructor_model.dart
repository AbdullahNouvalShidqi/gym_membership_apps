class InstructorModel {
  int idInstructor;
  String name;
  String contact;
  String email;

  InstructorModel({
    required this.idInstructor,
    required this.name,
    required this.contact,
    required this.email
  });

  InstructorModel.fromJson(Map<String, dynamic> json)
  : idInstructor = json['id_instructor'],
    name = json['name'],
    contact = json['contact'],
    email = json['email']
  ;
}
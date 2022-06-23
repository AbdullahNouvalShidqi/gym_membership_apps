class InstructorModel {
  int id;
  String name;
  String contact;
  String email;

  InstructorModel({
    required this.id,
    required this.name,
    required this.contact,
    required this.email
  });

  InstructorModel.fromJson(Map<String, dynamic> json)
  : 
    id = json['id'],
    name = json['name'],
    contact = json['contact'],
    email = json['email']
  ;

   toJson() =>{
    'id' : id,
    'name' : name,
    'contact' : contact,
    'email' : email
  };
}
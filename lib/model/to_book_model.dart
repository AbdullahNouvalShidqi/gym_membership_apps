class ToBookModel {
  int classId;
  int idUser;

  ToBookModel({required this.classId, required this.idUser});

  toJson() => {
        'classId': {
          'id': classId,
        },
        'idUser': {
          'id': idUser,
        }
      };
}

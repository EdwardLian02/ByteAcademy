// ignore: file_names
class UserModel {
  final int id;
  final String email;
  final String name;
  final String password;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) => UserModel(
        id: data['id'],
        email: data['email'],
        name: data['name'],
        password: data['password'],
      );

  static Map<String, dynamic> toJson(UserModel course) => {
        'id': course.id,
        'email': course.email,
        'name': course.name,
        'password': course.password,
      };
}

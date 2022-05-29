

class User {
  String id;
  String fullName;
  String email;
  int phoneNumber;
  String password;
  User(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.phoneNumber,
      required this.password});

  static User fromJson(json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "fullName" : fullName,
      "email" : email,
      "phoneNumber" : phoneNumber,
      "password" : password,
    };
  }
}

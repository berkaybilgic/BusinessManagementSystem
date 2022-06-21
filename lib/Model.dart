class UserModel {
  String? email;
  String? role;
  String? userName;

// receiving data
  UserModel({this.email, this.role, this.userName});

  factory UserModel.fromMap(map) {
    return UserModel(
      email: map['email'],
      role: map['role'],
      userName: map['userName'],
    );
  }

// sending data
  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }
}

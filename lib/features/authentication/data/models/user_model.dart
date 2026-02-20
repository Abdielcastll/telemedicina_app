import 'package:telemedicina_app/features/authentication/_export.dart';

class UserModel extends User {
  const UserModel({
    required super.userId,
    required super.name,
    required super.lastName,
    required super.secondLastName,
    required super.userCode,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: (json['UserId'] as num?)?.toInt() ?? 0,
      name: (json['Name'] ?? '').toString(),
      lastName: (json['LastName'] ?? '').toString(),
      secondLastName: (json['SecondLastName'] ?? '').toString(),
      userCode: (json['UserCode'] ?? '').toString(),
      email: (json['Email'] ?? '').toString(),
    );
  }

  factory UserModel.fromLoginJson(Map<String, dynamic> json) {
    return UserModel(
      userId: (json['UserId'] as num?)?.toInt() ?? 0,
      name: (json['Name'] ?? '').toString(),
      lastName: (json['LastName'] ?? '').toString(),
      secondLastName: (json['SecondLastName'] ?? '').toString(),
      userCode: (json['UserCode'] ?? '').toString(),
      email: (json['Email'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'Name': name,
      'LastName': lastName,
      'SecondLastName': secondLastName,
      'UserCode': userCode,
      'Email': email,
    };
  }
}

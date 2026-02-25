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
    final fullName = (json['FullName'] ?? '').toString().trim();
    final fullNameParts = fullName
        .split(RegExp(r'\s+'))
        .where((segment) => segment.isNotEmpty)
        .toList();

    final fallbackName = fullNameParts.isNotEmpty ? fullNameParts.first : '';
    final fallbackLastName = fullNameParts.length > 1 ? fullNameParts[1] : '';
    final fallbackSecondLastName = fullNameParts.length > 2
        ? fullNameParts.sublist(2).join(' ')
        : '';

    return UserModel(
      userId: (json['UserId'] as num?)?.toInt() ?? 0,
      name: (json['Name'] ?? '').toString().trim().isNotEmpty
          ? (json['Name'] ?? '').toString()
          : fallbackName,
      lastName: (json['LastName'] ?? '').toString().trim().isNotEmpty
          ? (json['LastName'] ?? '').toString()
          : fallbackLastName,
      secondLastName:
          (json['SecondLastName'] ?? '').toString().trim().isNotEmpty
          ? (json['SecondLastName'] ?? '').toString()
          : fallbackSecondLastName,
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

import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.userId,
    required this.name,
    required this.lastName,
    required this.secondLastName,
    required this.userCode,
    required this.email,
  });

  final int userId;
  final String name;
  final String lastName;
  final String secondLastName;
  final String userCode;
  final String email;

  @override
  List<Object> get props => [
    userId,
    name,
    lastName,
    secondLastName,
    userCode,
    email,
  ];
}

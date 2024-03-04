import 'package:equatable/equatable.dart';

class User extends Equatable {
  User({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object?> get props => [
    username, password
  ];
}
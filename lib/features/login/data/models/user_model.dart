import 'dart:convert';

import 'package:tdd_clean_arch/features/login/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required this.username, required this.password}) : super(username: username, password: password);

  final String username;
  final String password;

  // factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(username: json['username'], password: json['password']);

  Map<String, dynamic> toMap() => {
    "username": username,
    "password": password
  };
}

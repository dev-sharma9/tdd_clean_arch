import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/features/login/data/models/user_model.dart';
import 'package:tdd_clean_arch/features/login/domain/entities/user.dart';

void main() {
  final userModel = UserModel(
    username: 'michael',
    password: 'success'
  );

  group('Entity Testing', () {
    test('should be a User entity', () {
      expect(userModel, isA<User>());
    });

    test('fromJson should return a valid json', () {
      const userJson = '''
      {
          "username": "michael",
          "password": "success"
      }
      ''';
      final Map<String, dynamic> jsonMap = json.decode(userJson);
      final result = UserModel.fromMap(jsonMap);
      expect(result, userModel);
    });

    test('toJson should return a valid model', () {
      final result = userModel.toMap();

      final expectedMap = {
        "username": "michael",
        "password": "success"
      };

      expect(expectedMap, result);
    });
  });
}
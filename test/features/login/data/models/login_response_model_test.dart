import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/features/login/data/models/login_response_model.dart';
import 'package:tdd_clean_arch/features/login/domain/entities/login_response.dart';

void main() {
  final loginResponse = LoginResponseModel(
    success : true,
    message:"Login successful",
    token: "eyJhbGciOiJIUzI1NiImlzcyOk3GlHs8d2yjfYGZ9gYqWfx2wDPY7mTf",
    error: ErrorM(
      code: "invalid_credentials",
      message: "Invalid username or password."
    )
  );

  group('Login Entity tests', () {
    test('should be a valid Login entity', () {
      expect(loginResponse, isA<LoginResponse>());
    });

    test('fromJson should return a valid json', () {

      final jsonString = '{"success": true, "message": "Login successful", "token": "token123", "error": null}';

      final loginResponse = LoginResponseModel.fromJson(jsonString);

      expect(loginResponse.success, true);
      expect(loginResponse.message, 'Login successful');
      expect(loginResponse.token, 'token123');
      expect(loginResponse.error, isNull);
    });

    test('toMap should return a valid model', () {
      final result = loginResponse.toMap();

      final expectedMap = {
        "success": true,
        "message": "Login successful",
        "token": "eyJhbGciOiJIUzI1NiImlzcyOk3GlHs8d2yjfYGZ9gYqWfx2wDPY7mTf",
        "error": {
          "code": "invalid_credentials",
          "message": "Invalid username or password."
        }
      };
      expect(expectedMap, result);
    });
  });
}
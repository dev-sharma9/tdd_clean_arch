import 'dart:convert';
import 'package:tdd_clean_arch/features/login/domain/entities/login_response.dart';

class LoginResponseModel extends LoginResponse {
  final bool? success;
  final String? message;
  final String? token;
  final ErrorM? error;

  LoginResponseModel({required this.success, required this.message, required this.token, required this.error})
      : super(success: success, message: message, token: token, error: error);

  factory LoginResponseModel.fromJson(String str) => LoginResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromMap(Map<String, dynamic> json) => LoginResponseModel(
      success: json["success"], message: json["message"], token: json["token"],
      error: json["error"] == null ? null : ErrorModel.fromJson(json["error"])
  );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "token": token,
        "error": {
          "code": error?.code,
          "message": error?.message,
        }
      };
}

class ErrorModel extends ErrorM {
  final String code;
  final String message;

  ErrorModel({required this.code, required this.message}) : super(code: code, message: message);

  factory ErrorModel.fromJson(Map<String, dynamic> json){
    return ErrorModel(
      code: json["code"],
      message: json["message"],
    );
  }

}

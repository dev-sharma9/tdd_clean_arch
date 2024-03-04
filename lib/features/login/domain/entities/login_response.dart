import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final bool? success;
  final String? message;
  final String? token;
  final ErrorM? error;

  LoginResponse({required this.success,required this.message,required this.token, this.error});

  @override
  List<Object?> get props => [success, message, token, error];
}

class ErrorM {
  final String? code;
  final String? message;

  ErrorM({required this.code,required this.message});
}

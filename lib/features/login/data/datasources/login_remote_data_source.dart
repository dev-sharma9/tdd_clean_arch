import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network_info.dart';
import '../../../../core/utils/app_constants.dart';
import '../../domain/entities/login_response.dart';
import '../../domain/entities/user.dart';
import '../models/login_response_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponse> loginUser(User user);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginResponse> loginUser(User user) async {
    final response = await client.post(Uri.parse(AppConstants.apiBaseUrl + AppConstants.methodLogin),
        body: {
          "username": user.username,
          "password": user.password,
        });

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(response.body);
    }
    else if(response.statusCode == 401) {
      return LoginResponseModel.fromJson(response.body);
    }
    else {
      throw ServerException();
    }
  }
}


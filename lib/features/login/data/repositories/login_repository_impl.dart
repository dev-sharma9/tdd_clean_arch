import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_clean_arch/core/error/exception.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';
import 'package:tdd_clean_arch/core/utils/app_constants.dart';
import 'package:tdd_clean_arch/features/login/data/datasources/login_remote_data_source.dart';
import 'package:tdd_clean_arch/features/login/domain/entities/login_response.dart';
import 'package:tdd_clean_arch/features/login/domain/repositories/login_repository.dart';

import '../../../../core/network_info.dart';
import '../../domain/entities/user.dart';
import '../models/login_response_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, LoginResponse>> loginUser(User user) async {
    if(await networkInfo.isConnected) {
      try {
        final loginResponse = await remoteDataSource.loginUser(user);
        return Right(loginResponse);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    else {
      return Left(ServerFailure());
    }
  }
}

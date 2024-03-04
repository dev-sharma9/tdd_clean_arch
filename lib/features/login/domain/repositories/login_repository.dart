import 'package:dartz/dartz.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';
import 'package:tdd_clean_arch/features/login/domain/entities/login_response.dart';

import '../entities/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginResponse>> loginUser(User user);
}
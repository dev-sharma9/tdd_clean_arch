import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_arch/core/error/exception.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';
import 'package:tdd_clean_arch/features/login/data/models/login_response_model.dart';
import 'package:tdd_clean_arch/features/login/data/models/user_model.dart';
import 'package:tdd_clean_arch/features/login/domain/entities/login_response.dart';
import 'package:tdd_clean_arch/features/login/domain/entities/user.dart';
import 'package:tdd_clean_arch/features/login/domain/repositories/login_repository.dart';
import 'package:tdd_clean_arch/features/login/domain/usecases/login_use_case.dart';

class MockRepository extends Mock implements LoginRepository {}

void main() {
  late MockRepository mockRepository;
  late LoginUseCase useCase;

  setUp(() {
    mockRepository = MockRepository();
    useCase = LoginUseCase(mockRepository);
  });

  group('Login Use case test', () {
    final userModel = User(username: "username", password: "password");
    final userModelFail = User(username: "username", password: "fail");

    final loginResponse = LoginResponseModel(success: true, message: "Login successful", token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNjgwMjM5MDIyLCJleHAiOjI2MTkzMDAwMDAsImlzcyI6ImJlZWNlcHRvci5jb20iLCJhdWQiOiJCZWVjZXB0b3IgdXNlcnMifQ.D-wEdKyDTOk3GlHs8d2yjfYGZ9gYqWfx2wDPY7mTf-w",
        error: null);

    final failResponse = LoginResponseModel(success: false, message: null, token: null,
        error: ErrorModel(
          code: "invalid_credentials",
          message: "Invalid username or password."
        ));

    test('should return true when the call to remote data source is successful', () async {
      when(()=> mockRepository.loginUser(userModel)).thenAnswer((invocation) async => Right(loginResponse));

      final result = await useCase.call(userModel);
      expect(result, loginResponse.success);
    });

    test('should return false when the call to remote data source is unsuccessful', () async {
      when(()=> mockRepository.loginUser(userModelFail)).thenAnswer((invocation) async => Right(failResponse));

      final result = await useCase.call(userModelFail);
      expect(result, failResponse.success);
    });
  });
}
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_clean_arch/core/error/exception.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';
import 'package:tdd_clean_arch/core/network_info.dart';
import 'package:tdd_clean_arch/core/utils/app_constants.dart';
import 'package:tdd_clean_arch/features/login/data/datasources/login_remote_data_source.dart';
import 'package:tdd_clean_arch/features/login/data/models/login_response_model.dart';
import 'package:tdd_clean_arch/features/login/data/models/user_model.dart';
import 'package:tdd_clean_arch/features/login/data/repositories/login_repository_impl.dart';
import 'package:tdd_clean_arch/features/login/domain/entities/login_response.dart';
import 'package:tdd_clean_arch/features/login/domain/entities/user.dart';
import 'package:tdd_clean_arch/features/login/domain/repositories/login_repository.dart';

class MockRemoteDataSource extends Mock implements LoginRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late LoginRepositoryImpl loginRepository;

  setUpAll(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    loginRepository = LoginRepositoryImpl(remoteDataSource: mockRemoteDataSource,
        networkInfo: mockNetworkInfo,
    );
  });

  group('Login RepositoryImpl test', () {
    final userModel = User(username: "username", password: "password");

    const loginResponse = '''
          {
              "success": true,
              "message": "Login successful",
              "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNjgwMjM5MDIyLCJleHAiOjI2MTkzMDAwMDAsImlzcyI6ImJlZWNlcHRvci5jb20iLCJhdWQiOiJCZWVjZXB0b3IgdXNlcnMifQ.D-wEdKyDTOk3GlHs8d2yjfYGZ9gYqWfx2wDPY7mTf-w"
          }
        ''';

    test('should check if device is online', () async {

      when(() => mockRemoteDataSource.loginUser(userModel)).thenAnswer((invocation) async =>
          LoginResponseModel.fromJson(loginResponse)
      );
      when(() => mockNetworkInfo.isConnected).thenAnswer((invocation) async => true);

      await loginRepository.loginUser(userModel);
      verify(() => mockNetworkInfo.isConnected);
    });

    final loginResponse2 = LoginResponse(success: true, message: "Login successful", token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNjgwMjM5MDIyLCJleHAiOjI2MTkzMDAwMDAsImlzcyI6ImJlZWNlcHRvci5jb20iLCJhdWQiOiJCZWVjZXB0b3IgdXNlcnMifQ.D-wEdKyDTOk3GlHs8d2yjfYGZ9gYqWfx2wDPY7mTf-w");

    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
            () async {
          when(() => mockRemoteDataSource.loginUser(userModel))
              .thenAnswer((_) async => loginResponse2);

          final result = await loginRepository.loginUser(userModel);

          verify(() => mockRemoteDataSource.loginUser(userModel));
          expect(result, equals(Right(loginResponse2)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          when(() => mockRemoteDataSource.loginUser(userModel))
              .thenThrow(ServerException());

          final result = await loginRepository.loginUser(userModel);

          verify(() => mockRemoteDataSource.loginUser(userModel));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_arch/core/utils/app_constants.dart';
import 'package:tdd_clean_arch/features/login/data/datasources/login_remote_data_source.dart';
import 'package:tdd_clean_arch/features/login/data/models/user_model.dart';
import 'package:tdd_clean_arch/features/login/domain/entities/login_response.dart';
import 'package:tdd_clean_arch/features/login/domain/entities/user.dart';

class MockClient extends Mock implements Client {}
class MockUri extends Fake implements Uri {}

void main() {
  late MockClient mockClient;
  late LoginRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockClient= MockClient();
    remoteDataSource = LoginRemoteDataSourceImpl(client: mockClient);
  });

  setUpAll(() {
    registerFallbackValue(MockUri());
  });

  group('loginUser testing', () {
    const username = "michael";
    const password = "success-password";

    test('should return login response when the response code is 200', () async {
      when(() => mockClient.post(Uri.parse(AppConstants.apiBaseUrl + AppConstants.methodLogin),
          body: {"username": username, "password": password}))
          .thenAnswer(
            (_) async =>
            Response('''
              {
                  "success": true,
                  "message": "Login successful",
                  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNjgwMjM5MDIyLCJleHAiOjI2MTkzMDAwMDAsImlzcyI6ImJlZWNlcHRvci5jb20iLCJhdWQiOiJCZWVjZXB0b3IgdXNlcnMifQ.D-wEdKyDTOk3GlHs8d2yjfYGZ9gYqWfx2wDPY7mTf-w"
              }
            ''', 200),
      );

      final result = await remoteDataSource.loginUser(UserModel(username: username, password: password));

      expect(result, isA<LoginResponse>());
    });
  });

  test('given loginUser functions with invalid credentials when called should return valid fail response', () async {
    const username = 'username';
    const password = 'fail';

    when(() => mockClient.post(Uri.parse(AppConstants.apiBaseUrl + AppConstants.methodLogin),
        body: {"username":username, "password": password})).thenAnswer((invocation) async {
      return Response('''
          {
              "success": false,
              "error": {
                  "code": "invalid_credentials",
                  "message": "Invalid username or password."
              }
          }
        ''', 401);
    });

    final result = await remoteDataSource.loginUser(User(username: username, password: password));

    expect(result.success, false);
  });

}
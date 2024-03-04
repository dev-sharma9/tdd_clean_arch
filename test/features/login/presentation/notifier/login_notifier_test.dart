import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_arch/features/login/domain/entities/user.dart';
import 'package:tdd_clean_arch/features/login/domain/usecases/login_use_case.dart';
import 'package:tdd_clean_arch/features/login/presentation/notifier/login_notifier.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late LoginNotifier loginNotifier;
  late MockLoginUseCase mockLoginUseCase;

  setUpAll(() {
    mockLoginUseCase = MockLoginUseCase();
    loginNotifier = LoginNotifier(mockLoginUseCase);
  });

  group('Login Notifier test', () {
    test('Login success', () async {
      final user = User(username: 'test', password: 'password');
      when(() => mockLoginUseCase.call(user)).thenAnswer((invocation) => Future(() => true));

      await loginNotifier.login(user);

      expect(loginNotifier.state.isLoggedIn, true);
      expect(loginNotifier.state.error, null);
    });

    test('Login failed', () async {
      final user = User(username: 'test', password: 'fail');
      when(() => mockLoginUseCase.call(user)).thenAnswer((invocation) => Future(() => false));

      await loginNotifier.login(user);

      expect(loginNotifier.state.isLoggedIn, false);
      expect(loginNotifier.state.error, 'Login failed');
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/features/login/presentation/notifier/login_state.dart';

void main() {
  group('Login State test', () {
    test('copyWith should return a LoginState with updated isLoggedIn ', () {
      final initialState = LoginState(isLoggedIn: false, error: 'Test error');

      final newState = initialState.copyWith(isLoggedIn: true);

      expect(newState.isLoggedIn, true);
      expect(newState.error, 'Test error');
    });

    test('copyWith should return a new LoginState with updated error', () {
      final initialState = LoginState(isLoggedIn: true, error: 'Test error');

      final newState = initialState.copyWith(error: 'New error');

      expect(newState.error, 'New error');
      expect(newState.isLoggedIn, true);
    });
  });
}
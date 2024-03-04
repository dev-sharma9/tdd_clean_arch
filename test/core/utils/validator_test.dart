import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/core/utils/validator.dart';

void main() {
  group('Testing validation login', () {
    test('given username when called validatePassword function should validate it and return true/false',  () {
      final validUsername = Validator.validateUsername('michael');
      expect(validUsername, null);

      final nullUsername = Validator.validateUsername(null);
      expect(nullUsername, 'Username cannot be null');

      // not empty
      final invalidUsername1 = Validator.validateUsername('');
      expect(invalidUsername1, 'Username cannot be empty');

      // greater then 3 characters
      final invalidUsername2 = Validator.validateUsername('111');
      expect(invalidUsername2, 'Invalid username');
    });
  });

  test('given password when called validatePassword function should validate it and return true/false', () {
    final validPassword = Validator.validatePassword('success');
    expect(validPassword, null);

    final nullPassword = Validator.validatePassword(null);
    expect(nullPassword, 'Password cannot be null');

    // not empty
    final invalidPassword1 = Validator.validatePassword('');
    expect(invalidPassword1, 'Password cannot be empty');

    // greater than 3 characters
    final invalidPassword2 = Validator.validatePassword('aaa');
    expect(invalidPassword2, 'Invalid password');
  });
}
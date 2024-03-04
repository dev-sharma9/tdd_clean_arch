import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';

void main() {
  group('Failure', () {
    test('props should return an empty list', () {
      const failure = Failure();

      final props = failure.props;

      expect(props, isEmpty);
    });
  });

  group('ServerFailure', () {
    test('props should return an empty list', () {
      final serverFailure = ServerFailure();

      final props = serverFailure.props;

      expect(props, isEmpty);
    });
  });
}
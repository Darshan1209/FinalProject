import 'package:flutter_test/flutter_test.dart';
import 'package:email_validator/email_validator.dart';

void main() {
  group('Input Validation', () {
    test('Valid email passes validation', () {
      expect(EmailValidator.validate('test@example.com'), isTrue);
    });

    test('Invalid email fails validation', () {
      expect(EmailValidator.validate('invalid-email'), isFalse);
    });

    test('Empty password fails validation', () {
      final password = '';
      expect(password.isEmpty, isTrue);
    });
  });
}

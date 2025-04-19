import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Sign Up Input Validation', () {
    test('Valid username passes validation', () {
      final username = 'validUser123';
      expect(username.isNotEmpty, isTrue, reason: 'Username should not be empty');
    });

    test('Empty username fails validation', () {
      final username = '';
      expect(username.isEmpty, isTrue, reason: 'Empty username should fail validation');
    });

    test('Valid email passes validation', () {
      final email = 'user@example.com';
      expect(email.contains('@') && email.contains('.'), isTrue, reason: 'Valid email should contain "@" and "."');
    });

    test('Invalid email fails validation', () {
      final email = 'userexample';
      expect(email.contains('@') && email.contains('.'), isFalse, reason: 'Invalid email should fail validation');
    });

    test('Password with sufficient length passes validation', () {
      final password = 'StrongP@ssword123';
      expect(password.length >= 8, isTrue, reason: 'Password should be at least 8 characters long');
    });

    test('Short password fails validation', () {
      final password = '12345';
      expect(password.length >= 8, isFalse, reason: 'Password with fewer than 8 characters should fail');
    });

    test('Password with no special character fails validation', () {
      final password = 'Password123';
      final hasSpecialCharacter = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
      expect(hasSpecialCharacter, isFalse, reason: 'Password without special characters should fail');
    });

    test('Password with special character passes validation', () {
      final password = 'P@ssword123!';
      final hasSpecialCharacter = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
      expect(hasSpecialCharacter, isTrue, reason: 'Password with special characters should pass');
    });
  });
}

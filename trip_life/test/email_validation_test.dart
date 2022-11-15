// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:trip_life/app/modules/form/email_validation.dart';

void main() {
  test('email adress should be validated', () {
    final emailValid = "test@test.fr";
    final emailValidation = Validators.isEmailValid(emailValid);
    expect(emailValidation, true);
  });
  test('email adress should not be validated', () {
    final emailInvalid = "<>test@test.fr";
    final emailValidation = Validators.isEmailValid(emailInvalid);
    expect(emailValidation, false);
  });;
}

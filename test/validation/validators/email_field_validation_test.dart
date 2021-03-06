import 'package:test/test.dart';

import 'package:for_dev/validation/validators/email_field_validation.dart';

main() {
  late EmailFieldValidation sut;

  setUp(() {
    sut = EmailFieldValidation('any_field');
  });
  
  test('Should return null if email is empty', () {
    final error = sut.validate('');

    expect(error, null);
  });
  
  test('Should return null if email is null', () {
    final error = sut.validate(null);

    expect(error, null);
  });
  
  test('Should return null if email is valid', () {
    final error = sut.validate('barreira266@hotmail.com');

    expect(error, null);
  });
  
  test('Should return error if email is invalid', () {
    final error = sut.validate('barreira266@hotmail');

    expect(error, 'Campo inválido');
  });

}
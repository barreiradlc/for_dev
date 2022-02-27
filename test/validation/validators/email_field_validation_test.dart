import 'package:test/test.dart';

import 'package:for_dev/validation/protocols/field_validation.dart';

class EmailFieldValidation implements FieldValidation {
  final String field;

  EmailFieldValidation(this.field);

  String? validate(String? value){
    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if(value?.isNotEmpty != true || regex.hasMatch(value!)){
      return null;
    }
    return 'Campo inválido';
  }
}

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
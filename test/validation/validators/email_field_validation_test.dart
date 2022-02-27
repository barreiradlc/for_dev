import 'package:test/test.dart';

import 'package:for_dev/validation/protocols/field_validation.dart';

class EmailFieldValidation implements FieldValidation {
  final String field;

  EmailFieldValidation(this.field);

  String? validate(String? value){
    return null;
  }
}

main() {
  
  test('Should return null if email is empty', () {
    final sut = EmailFieldValidation('any_field');

    final error = sut.validate('');

    expect(error, null);
  });

}
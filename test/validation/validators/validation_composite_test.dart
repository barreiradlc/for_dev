import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:for_dev/presentation/protocols/validation.dart';

import 'package:for_dev/validation/protocols/field_validation.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  String? validate({ required String field, required String value }){
    return null;
  }
}

class FieldValidationSpy extends Mock implements FieldValidation{
  
}

main() {
  test('Should return null if all validations returns null or empty', () {
    final firstValidation = FieldValidationSpy();
    when(() => firstValidation.field).thenReturn('any_field');
    when(() => firstValidation.validate(any())).thenReturn(null);
    final secondValidation = FieldValidationSpy();
    when(() => secondValidation.field).thenReturn('any_field');
    when(() => secondValidation.validate(any())).thenReturn('');
    
    final sut = ValidationComposite([ firstValidation, secondValidation ]);

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });
}
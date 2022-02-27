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

class FieldValidationSpy extends Mock implements FieldValidation{}

main() {
  late ValidationComposite sut;
  late FieldValidationSpy firstValidation;
  late FieldValidationSpy secondValidation;
  late FieldValidationSpy thirdValidation;

  void mockFirstValidation(String? error) {
    when(() => firstValidation.validate(any())).thenReturn(error);
  }
  
  void mockSecondValidation(String? error) {
    when(() => secondValidation.validate(any())).thenReturn(error);
  }
  
  void mockThirdValidation(String? error) {
    when(() => thirdValidation.validate(any())).thenReturn(error);
  }

  setUp(() {
    firstValidation = FieldValidationSpy();
    secondValidation = FieldValidationSpy();
    thirdValidation = FieldValidationSpy();

    when(() => firstValidation.field).thenReturn('any_field');
    when(() => secondValidation.field).thenReturn('any_field');
    when(() => thirdValidation.field).thenReturn('other_field');
    
    mockFirstValidation(null);
    mockSecondValidation(null); 
    mockThirdValidation(null); 

    sut = ValidationComposite([ firstValidation, secondValidation, thirdValidation ]);
  });

  test('Should return null if all validations returns null or empty', () {
    mockSecondValidation(''); 

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });
}
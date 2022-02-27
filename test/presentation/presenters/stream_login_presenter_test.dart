import 'dart:async';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:for_dev/presentation/presenters/stream_login_presenter.dart';
import 'package:for_dev/presentation/protocols/validation.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  late ValidationSpy validation;
  late StreamLoginPresenter sut;
  late String email;

  mockValidationCall(String? field) =>
    when(() => validation.validate(field: field == null ? any(named: 'field') : field, value: any(named: 'value')));

  void mockValidation({ String? field, String? value }) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    mockValidation();
  });
  
  test('Should call validation with correct email', (){
    sut.validateEmail(email);
    
    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });
  
  test('Should emit validation error on incorrect email', (){
    mockValidation(value: 'error');
      
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);    
    sut.validateEmail(email);    
  });
}
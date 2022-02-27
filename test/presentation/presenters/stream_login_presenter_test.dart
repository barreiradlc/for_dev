import 'dart:async';
import 'package:faker/faker.dart';
import 'package:for_dev/domain/helpers/domain_error.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:for_dev/domain/entities/account_entity.dart';
import 'package:for_dev/domain/use_cases/authentication.dart';

import 'package:for_dev/presentation/presenters/stream_login_presenter.dart';
import 'package:for_dev/presentation/protocols/validation.dart';

class ValidationSpy extends Mock implements Validation {}
class AuthenticationSpy extends Mock implements Authentication {}

void main() {
  late ValidationSpy validation;
  late AuthenticationSpy authentication;
  late StreamLoginPresenter sut;
  late String email;
  late String password;

  mockValidationCall(String? field) =>
    when(() => validation.validate(field: field == null ? any(named: 'field') : field, value: any(named: 'value')));

  void mockValidation({ String? field, String? value }) {
    mockValidationCall(field).thenReturn(value);
  }
  
  mockAuthenticationCall() => when(
    () => authentication.auth(
      AuthenticationParams(
        email: email,
        secret: password
      )
    )
  );

  void mockAuthentication() {
    mockAuthenticationCall().thenAnswer((_) async => AccountEntity(faker.guid.guid()));
  }
  
  void mockAuthenticationError(DomainError domainError) {
    mockAuthenticationCall().thenThrow(domainError);
  }

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    sut = StreamLoginPresenter(validation: validation, authentication: authentication);
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation();
    mockAuthentication();
  });

  setUpAll((){
    registerFallbackValue(AuthenticationParams);
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
  
  test('Should emit null if validation of email succeeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);    
    sut.validateEmail(email);    
  });

  test('Should call validation with correct password', (){
    sut.validatePassword(password);
    
    verify(() => validation.validate(field: 'password', value: password)).called(1);
  });

  test('Should emit validation error on incorrect password', (){
    mockValidation(value: 'error');
      
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });
  
  test('Should emit null if validation of password succeeds', () {
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);    
  });

  test('Should emit password error if validation fails', () {
    mockValidation(field: 'email', value: 'error');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);    
    sut.validatePassword(password);    
  });
  
  test('Should not emit error if validation succeeds', () async {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateEmail(email);    
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });
  
  test('Should call Authetication with the correct values', () async {
    sut.validateEmail(email);        
    sut.validatePassword(password);

    await sut.auth();

    verify(() => authentication.auth(AuthenticationParams(email: email, secret: password))).called(1);
  });
  
  test('Should emit correct events on Authetication succeess', () async {
    // TODO -> Resolve this test
    sut.validateEmail(email);        
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.auth();
  });
  
  test('Should emit correct events on Authetication error', () async {
    mockAuthenticationError(DomainError.invalidCredentials);
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emits(false));
    sut.mainErrorStream.listen(expectAsync1((error) => expect(error, DomainError.invalidCredentials.description)));

    await sut.auth();
  });
}
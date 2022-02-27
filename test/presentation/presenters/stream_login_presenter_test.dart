import 'dart:async';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:for_dev/presentation/protocols/validation.dart';

class LoginState {
  String? emailError;
}
class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  LoginState _state = LoginState();

  Stream<String?> get emailErrorStream => _controller.stream.map((state) => state.emailError);

  StreamLoginPresenter({ required this.validation });

  void validateEmail(String email){
    _state.emailError = validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }
}

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
      
    expectLater(sut.emailErrorStream, emits('error'));

    sut.validateEmail(email);    
  });
}
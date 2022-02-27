import 'dart:async';

import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

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

abstract class Validation {
  String? validate({ required String field, required String value });
}

class ValidationSpy extends Mock implements Validation {}

void main() {
  late ValidationSpy validation;
  late StreamLoginPresenter sut;
  late String email;

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });
  
  test('Should call validation with correct email', (){
    sut.validateEmail(email);
    
    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });
  
  test('Should emit validation error on incorrect email', (){
    when(() => validation.validate(field: any(named: 'field'), value: any(named: 'value')))
      .thenReturn('error');
      
    expectLater(sut.emailErrorStream, emits('error'));

    sut.validateEmail(email);    
  });
}
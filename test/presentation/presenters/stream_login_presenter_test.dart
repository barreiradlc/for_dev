import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class StreamLoginPresenter {
  final Validation validation;

  StreamLoginPresenter({ required this.validation });

  void validateEmail(String email){
    validation.validate(field: 'email', value: email);
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
}
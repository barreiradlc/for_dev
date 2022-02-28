import 'package:test/test.dart';

import 'package:for_dev/main/factories/pages/login/login_validation_factory.dart';
import 'package:for_dev/validation/validators/email_field_validation.dart';
import 'package:for_dev/validation/validators/required_field_validation.dart';

main(){
  test('Should return the correct validations', () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      RequiredFieldValidation('password'),
      EmailFieldValidation('email')
    ]);
  });
}

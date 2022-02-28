import 'package:for_dev/main/builders/validation_builder.dart';
import 'package:test/test.dart';

import 'package:for_dev/main/factories/pages/login/login_validation_factory.dart';

main(){
  test('Should return the correct validations', () {
    final validations = makeLoginValidations();

    expect(validations, [
      ...ValidationBuilder.field('email')!.requiredField().emailField().build(),
      ...ValidationBuilder.field('password')!.requiredField().build()    
    ]);
  });
}

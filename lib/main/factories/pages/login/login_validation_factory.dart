import 'package:for_dev/main/builders/validation_builder.dart';
import 'package:for_dev/presentation/protocols/validation.dart';
import 'package:for_dev/validation/protocols/field_validation.dart';
import 'package:for_dev/validation/validators/email_field_validation.dart';
import 'package:for_dev/validation/validators/required_field_validation.dart';
import 'package:for_dev/validation/validators/validation_composite.dart';

Validation makeLoginValidation() {
  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    ...ValidationBuilder.field('email')!.requiredField().emailField().build(),
    ...ValidationBuilder.field('password')!.requiredField().build()    
  ];
}
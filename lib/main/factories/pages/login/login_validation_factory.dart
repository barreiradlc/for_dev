import 'package:for_dev/presentation/protocols/validation.dart';
import 'package:for_dev/validation/validators/email_field_validation.dart';
import 'package:for_dev/validation/validators/required_field_validation.dart';
import 'package:for_dev/validation/validators/validation_composite.dart';

Validation makeLoginValidation() {
  return ValidationComposite([
    RequiredFieldValidation('email'),
    RequiredFieldValidation('password'),
    EmailFieldValidation('email')
  ]);
}
import 'package:for_dev/validation/protocols/field_validation.dart';
import 'package:for_dev/validation/validators/email_field_validation.dart';
import 'package:for_dev/validation/validators/required_field_validation.dart';

class ValidationBuilder{
  static ValidationBuilder? _instance;
  late String fieldName;
  late List<FieldValidation> validations= [];

  ValidationBuilder._();

  static ValidationBuilder? field(String fieldName){
    _instance = ValidationBuilder._();
    _instance?.fieldName = fieldName;
    return _instance;
  }

  ValidationBuilder requiredField() {
    validations.add(RequiredFieldValidation(fieldName));
    return this;
  }
  
  ValidationBuilder emailField() {
    validations.add(EmailFieldValidation(fieldName));
    return this;
  }

  List<FieldValidation> build() => validations;
}
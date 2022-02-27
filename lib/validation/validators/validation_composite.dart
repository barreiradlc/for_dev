import 'package:for_dev/presentation/protocols/validation.dart';
import 'package:for_dev/validation/protocols/field_validation.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  String? validate({ required String field, required String value }){
    String? error = null;
    for (final validation in validations.where((currentValidation) => currentValidation.field == field)) {
      error = validation.validate(value);
      if(error?.isNotEmpty == true) {
        return error;
      }
    }
    if(error?.isEmpty == true){
      return null;
    }
    return error;
  }
}

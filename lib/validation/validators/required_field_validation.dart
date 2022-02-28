import 'package:equatable/equatable.dart';
import 'package:for_dev/validation/protocols/field_validation.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  final String field;

  RequiredFieldValidation(this.field);

  String? validate(String? value){
    if(value?.isNotEmpty == true){
      return null;
    }
    return 'Campo obrigatório';
  }

  @override
  List<Object?> get props => [field];
}
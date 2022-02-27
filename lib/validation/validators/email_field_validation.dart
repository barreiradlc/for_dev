import 'package:for_dev/validation/protocols/field_validation.dart';

class EmailFieldValidation implements FieldValidation {
  final String field;

  EmailFieldValidation(this.field);

  String? validate(String? value){
    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if(value?.isNotEmpty != true || regex.hasMatch(value!)){
      return null;
    }
    return 'Campo inválido';
  }
}

import 'dart:async';
import 'dart:ui';

import 'package:for_dev/domain/helpers/domain_error.dart';
import 'package:for_dev/domain/use_cases/authentication.dart';
import 'package:for_dev/presentation/protocols/validation.dart';
import 'package:for_dev/ui/pages/login/login_presenter.dart';
import 'package:get/get.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;

  String? _email;
  String? _password;
  
  RxString? _emailError = RxString('');
  RxString? _passwordError = RxString('');
  RxString? _mainError = RxString('');
  var _isFormValid = false.obs;
  var _isLoading = false.obs;

  Stream<String?>? get emailErrorStream => _emailError?.stream;
  Stream<String?>? get passwordErrorStream => _passwordError?.stream;
  Stream<String?>? get mainErrorStream => _mainError?.stream;
  Stream<bool>? get isFormValidStream => _isFormValid.stream;
  Stream<bool>? get isLoadingStream => _isLoading.stream;

  GetxLoginPresenter({ required this.validation, required this.authentication });

  void validateEmail(String email){
    _email = email;
    String? validationError = validation.validate(field: 'email', value: email);    
    _emailError?.value = validationError == null ? '' : validationError ;
    _validateForm();
  }
  
  void validatePassword(String password){
    _password = password;
    String? validationError = validation.validate(field: 'password', value: password);
    _passwordError?.value = validationError == null ? '' : validationError;
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = _passwordError?.isNotEmpty == false && _emailError?.isNotEmpty == false && _email != null && _password != null;
  }
  
  Future<void> auth() async {
    _isLoading.value = true;    
    try {
      await authentication.auth(AuthenticationParams(email: _email!, secret: _password!));
    } on DomainError catch (e) {
      _mainError?.value = e.description;
    }
    _isLoading.value = false;
  }

  void dispose() {}

}

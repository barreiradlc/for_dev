import 'package:for_dev/domain/entities/account_entity.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:for_dev/domain/helpers/domain_error.dart';
import 'package:for_dev/domain/use_cases/authentication.dart';
import 'package:for_dev/domain/use_cases/save_currect_account.dart';
import 'package:for_dev/presentation/protocols/validation.dart';
import 'package:for_dev/ui/pages/login/login_presenter.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount? saveCurrentAccount;

  String? _email;
  String? _password;
  
  RxString? _emailError = RxString('');
  RxString? _passwordError = RxString('');
  RxString? _mainError = RxString('');
  RxString? _navigateTo = RxString('');
  var _isFormValid = false.obs;
  var _isLoading = false.obs;

  Stream<String?>? get emailErrorStream => _emailError?.stream;
  Stream<String?>? get passwordErrorStream => _passwordError?.stream;
  Stream<String?>? get mainErrorStream => _mainError?.stream;
  Stream<String?>? get navigateToStream => _navigateTo?.stream;
  Stream<bool>? get isFormValidStream => _isFormValid.stream;
  Stream<bool>? get isLoadingStream => _isLoading.stream;

  GetxLoginPresenter({ required this.validation, required this.authentication, required this.saveCurrentAccount });

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
    try {
      _isLoading.value = true;    
      final account = await authentication.auth(AuthenticationParams(email: _email!, secret: _password!));
      await saveCurrentAccount?.save(account as AccountEntity);
      _navigateTo?.value = '/surveys';
    } on DomainError catch (e) {
      _mainError?.value = e.description;
      _isLoading.value = false;
    }
  }

  void dispose() {}

}

import 'dart:async';

import 'package:for_dev/domain/helpers/domain_error.dart';
import 'package:for_dev/domain/use_cases/authentication.dart';
import 'package:for_dev/presentation/protocols/validation.dart';

class LoginState {
  String? mainError;
  String? emailError;
  String? passwordError;
  
  String? email;
  String? password;

  bool isLoading = false;
  bool get isFormValid => passwordError == null && emailError == null && email != null && password != null;
}

class StreamLoginPresenter {
  final Validation validation;
  final Authentication authentication;
  StreamController<LoginState>? _controller = StreamController<LoginState>.broadcast();

  LoginState _state = LoginState();

  Stream<String?>? get emailErrorStream => _controller?.stream?.map((state) => state.emailError).distinct();
  Stream<String?>? get passwordErrorStream => _controller?.stream?.map((state) => state.passwordError).distinct();
  Stream<String?>? get mainErrorStream => _controller?.stream?.map((state) => state.mainError).distinct();
  Stream<bool>? get isFormValidStream => _controller?.stream?.map((state) => state.isFormValid).distinct();
  Stream<bool>? get isLoadingStream => _controller?.stream?.map((state) => state.isLoading).distinct();

  StreamLoginPresenter({ required this.validation, required this.authentication });

  void _update(){
    _controller?.add(_state);
  }

  void validateEmail(String email){
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);
    _update();
  }
  
  void validatePassword(String password){
    _state.password = password;
    _state.passwordError = validation.validate(field: 'password', value: password);
    _update();
  }
  
  Future<void> auth() async {
    _state.isLoading = true;
    _update();
    try {
      await authentication.auth(AuthenticationParams(email: _state.email!, secret: _state.password!));
    } on DomainError catch (e) {
      _state.mainError = e.description;
    }
    _state.isLoading = false;
    _update();
  }

  void dispose() {
    _controller?.close();
    _controller = null;
  }
}

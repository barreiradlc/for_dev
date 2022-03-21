import 'package:flutter/material.dart';

abstract class SignUpPresenter implements Listenable {
  Stream<String?>? get emailErrorStream;
  Stream<String?>? get nameErrorStream;
  Stream<String?>? get passwordErrorStream;  
  Stream<String?>? get passwordConfirmationErrorStream;  
  Stream<bool?>? get isFormValidStream;  

  void validateName(String name);
  void validateEmail(String email);
  void validatePassword(String password);
  void validatePasswordConfirmation(String passwordConfirmation);
  Future<void> signUp();
}
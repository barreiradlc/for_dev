import 'package:flutter/material.dart';

abstract class LoginPresenter implements Listenable {
  Stream<String?> get emailErrorStream;
  Stream<String?> get passwordErrorStream;

  void validateEmail(String email);
  void validatePassword(String email);
}
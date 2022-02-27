import 'package:flutter/material.dart';

abstract class LoginPresenter implements Listenable {
  Stream<String?> get emailErrorStream;

  void validateEmail(String email);
  void validatePassword(String email);
}
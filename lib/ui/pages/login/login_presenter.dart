import 'package:flutter/material.dart';

abstract class LoginPresenter implements Listenable {
  void validateEmail(String email);
  void validatePassword(String email);
}
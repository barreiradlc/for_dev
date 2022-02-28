import 'package:flutter/material.dart';

import 'package:for_dev/main/factories/pages/login/login_presenter_factory.dart';

import 'package:for_dev/ui/pages/login/login_page.dart';

Widget makeLoginPage() {
  return LoginPage(makeLoginPresenter());
}
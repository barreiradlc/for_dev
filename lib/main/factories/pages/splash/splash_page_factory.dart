import 'package:flutter/material.dart';
import 'package:for_dev/main/factories/pages/Splash/Splash_presenter_factory.dart';
import 'package:for_dev/ui/pages/splash/splash_page.dart';

Widget makeSplashPage() {
  return SplashPage(presenter: makeGetxSplashPresenter());
}
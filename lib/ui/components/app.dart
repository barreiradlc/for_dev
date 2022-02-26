import 'package:flutter/material.dart';

import 'package:for_dev/ui/pages/login_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: '4Dev', debugShowCheckedModeBanner: false, home: LoginPage());
  }
}

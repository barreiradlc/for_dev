import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_dev/utils/i18n/resources.dart';
import 'package:get/route_manager.dart';

import 'package:for_dev/ui/components/app_theme.dart';

import 'package:for_dev/main/factories/factories.dart';

void main() {  
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return GetMaterialApp(
      title: '4Dev', 
      debugShowCheckedModeBanner: false, 
      theme: makeAppTheme(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: makeSplashPage, transition: Transition.fade),
        GetPage(name: '/login', page: makeLoginPage, transition: Transition.fadeIn),
        GetPage(name: '/surveys', page: () => Scaffold(body: Center(child: Text('Enquetes'))), transition: Transition.fadeIn)
      ],
    );
  }
}
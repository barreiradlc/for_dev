import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:for_dev/ui/pages/splash/splash_page.dart';
import 'package:for_dev/ui/pages/splash/splash_presenter.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class SplashPresenterSpy extends Mock implements SplashPresenter{}

void main() {
  late SplashPresenterSpy presenter;
  late StreamController<String?> navigateToController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SplashPresenterSpy();
    navigateToController = StreamController<String?>();
    when(() => presenter.navigateToStream).thenAnswer((_) => navigateToController.stream);

    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => SplashPage(presenter: presenter)),
          GetPage(name: '/any_route', page: () => Scaffold(body: Text('fake page')))
        ]
      ),
    );
  }

  tearDown(() {
    navigateToController.close();
  });

  testWidgets('Should present spinner on page load', (WidgetTester tester) async {
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
  
  testWidgets('Should call loadCurrectAccount on page load', (WidgetTester tester) async {
    await loadPage(tester);

    verify(() => presenter.loadCurrentAccount()).called(1);
  });
  
  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('/any_route');
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/any_route');
    expect(find.text('fake page'), findsOneWidget);
  });
  
  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('');
    await tester.pump();
    expect(Get.currentRoute, '/');

    navigateToController.add(null);
    await tester.pump();
    expect(Get.currentRoute, '/');    
  });

}

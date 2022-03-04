import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;

  SplashPage({ required this.presenter });  


  @override
  Widget build(BuildContext context) {
    presenter.loadCurrentAccount();

    return Scaffold(
      appBar: AppBar(
        title: Text('4Dev'),
      ),
      body: Center(
        child: CircularProgressIndicator()
      )
    );
  }
}

abstract class SplashPresenter{
  Future<void>? loadCurrentAccount();
}

class SplashPresenterSpy extends Mock implements SplashPresenter{}

void main() {
  late SplashPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SplashPresenterSpy();
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => SplashPage(presenter: presenter))
        ]
      ),
    );
  }

  testWidgets('Should present spinner on page load', (WidgetTester tester) async {
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
  
  testWidgets('Should call loadCurrectAccount on page load', (WidgetTester tester) async {
    await loadPage(tester);

    verify(() => presenter.loadCurrentAccount()).called(1);
  });
}

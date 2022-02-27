import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:for_dev/ui/pages/login/login_page.dart';
import 'package:for_dev/ui/pages/login/login_presenter.dart';
import 'package:mocktail/mocktail.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  late LoginPresenter presenter;
  late StreamController<String?> emailErrorController;
  late StreamController<String?> passwordErrorController;
  late StreamController<String?> mainErrorController;
  late StreamController<bool?> isFormValidController;
  late StreamController<bool?> isLoadingController;

  Future<void> loadPage(WidgetTester tester) async{
    presenter = LoginPresenterSpy();
    emailErrorController = StreamController<String?>();
    passwordErrorController = StreamController<String?>();
    mainErrorController = StreamController<String?>();
    isFormValidController = StreamController<bool?>();
    isLoadingController = StreamController<bool?>();
    when(() => presenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => presenter.passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
    when(() => presenter.mainErrorStream).thenAnswer((_) => mainErrorController.stream);
    when(() => presenter.isFormValidStream).thenAnswer((_) => isFormValidController.stream);
    when(() => presenter.isLoadingStream).thenAnswer((_) => isLoadingController.stream);
    final page = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(page);
  }

  tearDown(() {
    emailErrorController.close();
    passwordErrorController.close();
    mainErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
  });

  testWidgets('Should Load with correct initial state', 
    (WidgetTester tester) async {
      await loadPage(tester);  

      final findEmailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text) );

      expect(
        findEmailTextChildren, 
        findsOneWidget, 
        reason: 'Since the Text field has only the label on initial state, the second represents the error text failing when is present'
      );
      
      final findPasswordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text) );

      expect(
        findPasswordTextChildren, 
        findsOneWidget, 
        reason: 'Since the Text field has only the label on initial state, the second represents the error text failing when is present'
      );

      final sendButton = tester.widget<RaisedButton>(find.byType(RaisedButton));
      expect(sendButton.onPressed, null);

      expect(find.byType(CircularProgressIndicator), findsNothing);
    }
  );

  testWidgets('Should call validate with correct values', 
    (WidgetTester tester) async {      
      await loadPage(tester);

      final email = faker.internet.email();
      await tester.enterText(find.bySemanticsLabel('Email'), email);
      
      verify(() => presenter.validateEmail(email));
      
      final password = faker.internet.password();
      await tester.enterText(find.bySemanticsLabel('Senha'), password);
      
      verify(() => presenter.validatePassword(password));
    }
  );
  
  testWidgets('Should present error if email is invalid', 
    (WidgetTester tester) async {      
      await loadPage(tester);

      emailErrorController.add('any_error');
      await tester.pump();

      expect(find.text('any_error'), findsOneWidget);
    }
  );

  testWidgets('Should present not error if email is valid', 
    (WidgetTester tester) async {      
      await loadPage(tester);

      emailErrorController.add(null);
      await tester.pump();


      expect(
        find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text)), 
        findsOneWidget      
      );
    }
  );
  
  testWidgets('Should present not error if email is valid with blank value', 
    (WidgetTester tester) async {      
      await loadPage(tester);

      emailErrorController.add(null);
      await tester.pump();

      expect(
        find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text)), 
        findsOneWidget      
      );
    }
  );
  
  testWidgets('Should present error if password is invalid', 
    (WidgetTester tester) async {      
      await loadPage(tester);

      passwordErrorController.add('any_error');
      await tester.pump();

      expect(find.text('any_error'), findsOneWidget);
    }
  );

  testWidgets('Should present not error if password is valid', 
    (WidgetTester tester) async {      
      await loadPage(tester);

      passwordErrorController.add(null);
      await tester.pump();


      expect(
        find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text)), 
        findsOneWidget      
      );
    }
  );
  
  testWidgets('Should present not error if password is valid with blank value', 
    (WidgetTester tester) async {      
      await loadPage(tester);

      emailErrorController.add(null);
      await tester.pump();

      expect(
        find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text)), 
        findsOneWidget      
      );
    }
  );
  
  testWidgets('Should enable form button if form is valid', 
    (WidgetTester tester) async { 
      await loadPage(tester);

      isFormValidController.add(true);
      await tester.pump();
  
      final sendButton = tester.widget<RaisedButton>(find.byType(RaisedButton));
      expect(sendButton.onPressed, isNotNull);
    }
  );
  
  testWidgets('Should disable form button if form is invalid', 
    (WidgetTester tester) async { 
      await loadPage(tester);

      isFormValidController.add(false);
      await tester.pump();
  
      final sendButton = tester.widget<RaisedButton>(find.byType(RaisedButton));
      expect(sendButton.onPressed, null);
    }
  );
  
  testWidgets('Should call authentication on form submit', 
    (WidgetTester tester) async { 
      await loadPage(tester);

      isFormValidController.add(true);
      await tester.pump();
      await tester.tap(find.byType(RaisedButton));
      await tester.pump();
  
      verify(() => presenter.auth()).called(1);
    }
  );
  
  testWidgets('Should present loading', 
    (WidgetTester tester) async { 

      await loadPage(tester);

      isLoadingController.add(true);
      await tester.pump();      
  
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    }
  );

  testWidgets('Should hide loading', 
    (WidgetTester tester) async { 
      await loadPage(tester);

      isLoadingController.add(true);
      await tester.pump();      
      isLoadingController.add(false);
      await tester.pump();      
  
      expect(find.byType(CircularProgressIndicator), findsNothing);
    }
  );

  testWidgets('Should present error message if authentication fails', 
    (WidgetTester tester) async { 
      await loadPage(tester);

      mainErrorController.add('main error');
      await tester.pump();            
  
      expect(find.text('main error'), findsOneWidget);
    }
  );

}
import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:for_dev/ui/pages/login/login_page.dart';
import 'package:for_dev/ui/pages/login/login_presenter.dart';
import 'package:for_dev/ui/pages/signup/signup_page.dart';
import 'package:for_dev/ui/pages/signup/signup_presenter.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class SignUpPresenterSpy extends Mock implements SignUpPresenter {}

void main() {
  late SignUpPresenter presenter;
  late StreamController<String?> nameErrorController;
  late StreamController<String?> emailErrorController;
  late StreamController<String?> passwordErrorController;
  late StreamController<String?> passwordConfirmationErrorController;

  void initStreams() {
    nameErrorController = StreamController<String?>();
    emailErrorController = StreamController<String?>();
    passwordErrorController = StreamController<String?>();
    passwordConfirmationErrorController = StreamController<String?>();
  }

  void mockStreams() {
    when(() => presenter.nameErrorStream).thenAnswer((_) => nameErrorController.stream);
    when(() => presenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => presenter.passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
    when(() => presenter.passwordConfirmationErrorStream).thenAnswer((_) => passwordConfirmationErrorController.stream);
  }

  void closeStreams() {
    nameErrorController.close();
    emailErrorController.close();
    passwordErrorController.close();
    passwordConfirmationErrorController.close();
  }

  Future<void> loadPage(WidgetTester tester) async{    
    presenter = SignUpPresenterSpy();
    initStreams();
    mockStreams();

    final page = GetMaterialApp(
      initialRoute: '/signup',
      getPages: [
        GetPage(name: '/signup', page: () => SignUpPage(presenter)),        
      ],
    );
    await tester.pumpWidget(page);
  };

  tearDown(() {
    closeStreams();
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
      
      final findNameTextChildren = find.descendant(of: find.bySemanticsLabel('Nome'), matching: find.byType(Text) );

      expect(
        findNameTextChildren, 
        findsOneWidget, 
        reason: 'Since the Text field has only the label on initial state, the second represents the error text failing when is present'
      );
      
      final findPasswordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text) );

      expect(
        findPasswordTextChildren, 
        findsOneWidget, 
        reason: 'Since the Text field has only the label on initial state, the second represents the error text failing when is present'
      );
    
      final findPasswordConfirmationTextChildren = find.descendant(of: find.bySemanticsLabel('Confirmar senha'), matching: find.byType(Text) );

      expect(
        findPasswordConfirmationTextChildren, 
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

      final name = faker.person.name();
      await tester.enterText(find.bySemanticsLabel('Nome'), name);
      verify(() => presenter.validateName(name));

      final email = faker.internet.email();
      await tester.enterText(find.bySemanticsLabel('Email'), email);
      verify(() => presenter.validateEmail(email));
      
      final password = faker.internet.password();
      await tester.enterText(find.bySemanticsLabel('Senha'), password);
      verify(() => presenter.validatePassword(password));
            
      await tester.enterText(find.bySemanticsLabel('Confirmar senha'), password);
      verify(() => presenter.validatePasswordConfirmation(password));
    }
  );
  
}
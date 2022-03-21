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
  late StreamController<String?> mainErrorController;
  late StreamController<String?> nameErrorController;
  late StreamController<String?> emailErrorController;
  late StreamController<String?> passwordErrorController;
  late StreamController<String?> passwordConfirmationErrorController;
  late StreamController<bool?> isFormValidController;
  late StreamController<bool?> isLoadingController;

  void initStreams() {
    mainErrorController = StreamController<String?>();
    nameErrorController = StreamController<String?>();
    emailErrorController = StreamController<String?>();
    passwordErrorController = StreamController<String?>();
    passwordConfirmationErrorController = StreamController<String?>();
    isFormValidController = StreamController<bool?>();
    isLoadingController = StreamController<bool?>();
  }

  void mockStreams() {
    when(() => presenter.mainErrorStream).thenAnswer((_) => mainErrorController.stream);
    when(() => presenter.nameErrorStream).thenAnswer((_) => nameErrorController.stream);
    when(() => presenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => presenter.passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
    when(() => presenter.passwordConfirmationErrorStream).thenAnswer((_) => passwordConfirmationErrorController.stream);
    when(() => presenter.isFormValidStream).thenAnswer((_) => isFormValidController.stream);
    when(() => presenter.isLoadingStream).thenAnswer((_) => isLoadingController.stream);
  }

  void closeStreams() {
    nameErrorController.close();
    emailErrorController.close();
    passwordErrorController.close();
    passwordConfirmationErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
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
  

  testWidgets('Should present name error', 
    (WidgetTester tester) async {      
      await loadPage(tester);

      nameErrorController.add('Campo inválido');
      await tester.pump();

      expect(find.text('Campo inválido'), findsOneWidget);
      
      nameErrorController.add('Campo obrigatório');
      await tester.pump();

      expect(find.text('Campo obrigatório'), findsOneWidget);

      nameErrorController.add(null);
      await tester.pump();

      expect(
        find.descendant(of: find.bySemanticsLabel('Nome'), matching: find.byType(Text)), 
        findsOneWidget      
      );
    }
  );
  
  testWidgets('Should present email error', 
    (WidgetTester tester) async {      
      await loadPage(tester);

      emailErrorController.add('Campo inválido');
      await tester.pump();

      expect(find.text('Campo inválido'), findsOneWidget);
      
      emailErrorController.add('Campo obrigatório');
      await tester.pump();

      expect(find.text('Campo obrigatório'), findsOneWidget);

      emailErrorController.add(null);
      await tester.pump();

      expect(
        find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text)), 
        findsOneWidget      
      );
    }
  );
  
  testWidgets('Should present password error', 
    (WidgetTester tester) async {      
      await loadPage(tester);

      passwordErrorController.add('Campo inválido');
      await tester.pump();

      expect(find.text('Campo inválido'), findsOneWidget);
      
      passwordErrorController.add('Campo obrigatório');
      await tester.pump();

      expect(find.text('Campo obrigatório'), findsOneWidget);

      passwordErrorController.add(null);
      await tester.pump();

      expect(
        find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text)), 
        findsOneWidget      
      );
    }
  );
  
  testWidgets('Should present password confirmation error', 
    (WidgetTester tester) async {      
      await loadPage(tester);

      passwordConfirmationErrorController.add('Campo inválido');
      await tester.pump();

      expect(find.text('Campo inválido'), findsOneWidget);
      
      passwordConfirmationErrorController.add('Campo obrigatório');
      await tester.pump();

      expect(find.text('Campo obrigatório'), findsOneWidget);

      passwordConfirmationErrorController.add(null);
      await tester.pump();

      expect(
        find.descendant(of: find.bySemanticsLabel('Confirmar senha'), matching: find.byType(Text)), 
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
   
  
  testWidgets('Should call signup on form submit', 
    (WidgetTester tester) async {
      await loadPage(tester);

      isFormValidController.add(true);
      await tester.pump();
      
      final button = find.byType(RaisedButton);

      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pump();
  
      verify(() => presenter.signUp()).called(1);
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


  testWidgets('Should present error message if signUp fails', 
    (WidgetTester tester) async { 
      await loadPage(tester);

      mainErrorController.add('main error');
      await tester.pump();            
  
      expect(find.text('main error'), findsOneWidget);
    }
  );

}
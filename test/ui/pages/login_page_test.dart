import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:for_dev/ui/pages/login_page.dart';

void main() {

  Future<void> loadPage(WidgetTester tester) async{
    final page = MaterialApp(home: LoginPage());
    await tester.pumpWidget(page);
  }
  testWidgets(
    'Should Load with correct initial state', 
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
    }
  );
  
}
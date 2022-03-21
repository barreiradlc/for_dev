import 'package:flutter/material.dart';

import 'package:for_dev/ui/components/error_snackbar.dart';
import 'package:for_dev/ui/components/headline1.dart';
import 'package:for_dev/ui/components/login/login_header.dart';
import 'package:for_dev/ui/components/spinner_dialog.dart';
import 'package:for_dev/ui/pages/signup/components/email_input.dart';

import 'package:for_dev/ui/pages/signup/components/name_input.dart';
import 'package:for_dev/ui/pages/signup/components/password_confirmation_input.dart';
import 'package:for_dev/ui/pages/signup/components/password_input.dart';
import 'package:for_dev/ui/pages/signup/components/signup_button.dart';
import 'package:for_dev/ui/pages/signup/signup_presenter.dart';
import 'package:for_dev/utils/i18n/resources.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  final SignUpPresenter presenter;
  
  SignUpPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    void _hideKeyboard() {
      final currentFocus = FocusScope.of(context);
      if(!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream?.listen((isLoading) {
            if(isLoading == true) {
              showLoadingSpinner(context);
            } else {
              hideLoadingSpinner(context);
            }
          });

          return GestureDetector(
            onTap: _hideKeyboard,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginPageHeader(theme: theme), 
                  Headline1(text: R.strings.addAccount), 
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: ListenableProvider(
                      create: (_) => presenter,
                      child: Form(
                        child: Column(
                          children: [
                            NameInput(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: EmailInput(),
                            ),
                            PasswordInput(),
                            Padding(
                              padding: const EdgeInsets.only(top : 8, bottom: 32),
                              child: PasswordConfirmationInput(),
                            ),
                            SignUpButton(),
                            FlatButton.icon(
                              onPressed: () {}, 
                              icon: Icon(Icons.person), 
                              label: Text(R.strings.login)
                            )
                          ]
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

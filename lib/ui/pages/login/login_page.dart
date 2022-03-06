import 'package:flutter/material.dart';

import 'package:for_dev/ui/components/error_snackbar.dart';
import 'package:for_dev/ui/components/headline1.dart';
import 'package:for_dev/ui/components/login/login_header.dart';
import 'package:for_dev/ui/components/spinner_dialog.dart';
import 'package:for_dev/ui/pages/login/components/email_input.dart';
import 'package:for_dev/ui/pages/login/components/login_button.dart';
import 'package:for_dev/ui/pages/login/components/password_input.dart';
import 'package:for_dev/ui/pages/login/login_presenter.dart';
import 'package:for_dev/utils/i18n/resources.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPresenter presenter;

  LoginPage(this.presenter);

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

          presenter.mainErrorStream?.listen((error) {
            if(error != null) {
              showErrorSnackBar(context, error);
            }
          });
          
          presenter.navigateToStream?.listen((page) {
            if(page?.isNotEmpty == true) {
              Get.offAllNamed(page!);
            }
          });

          return GestureDetector(
            onTap: _hideKeyboard,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginPageHeader(theme: theme), 
                  Headline1(text: 'Login'), 
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: 
                      ListenableProvider(
                        create: (_) => presenter,
                        child: Form(
                          child: Column(
                          children: [
                            EmailInput(),
                            Padding(
                              padding: const EdgeInsets.only(top : 8, bottom: 32),
                              child: PasswordInput(),
                            ),
                            LoginButton(),
                            FlatButton.icon(
                              onPressed: () {}, 
                              icon: Icon(Icons.person), 
                              label: Text(R.strings.addAccount)
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

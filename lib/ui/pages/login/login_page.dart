import 'package:flutter/material.dart';

import 'package:for_dev/ui/components/error_snackbar.dart';
import 'package:for_dev/ui/components/headline1.dart';
import 'package:for_dev/ui/components/login/login_header.dart';
import 'package:for_dev/ui/components/spinner_dialog.dart';
import 'package:for_dev/ui/pages/login/components/email_input.dart';
import 'package:for_dev/ui/pages/login/components/password_input.dart';
import 'package:for_dev/ui/pages/login/login_presenter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter.isLoadingStream.listen((isLoading) {
            if(isLoading == true) {
              showLoadingSpinner(context);
            } else {
              hideLoadingSpinner(context);
            }
          });

          widget.presenter.mainErrorStream.listen((error) {
            if(error != null) {
              showErrorSnackBar(context, error);
            }
          });

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginPageHeader(theme: theme), 
                Headline1(text: 'Login'), 
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: 
                    ListenableProvider(
                      create: (_) => widget.presenter,
                      child: Form(
                        child: Column(
                        children: [
                          EmailInput(),
                          Padding(
                            padding: const EdgeInsets.only(top : 8, bottom: 32),
                            child: PasswordInput(),
                          ),
                          StreamBuilder<bool?>(
                            stream: widget.presenter.isFormValidStream,
                            builder: (context, snapshot) {
                              return RaisedButton( 
                                onPressed: snapshot.data != true ? null : widget.presenter.auth, 
                                child: Text('Entrar')
                              );
                            }
                          ),
                          FlatButton.icon(
                            onPressed: () {}, 
                            icon: Icon(Icons.person), 
                            label: Text('Criar conta')
                          )
                        ]
                      )
                      ),
                    ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}



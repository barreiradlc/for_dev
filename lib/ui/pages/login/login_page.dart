import 'package:flutter/material.dart';
import 'package:for_dev/ui/components/headline1.dart';
import 'package:for_dev/ui/components/login/login_header.dart';
import 'package:for_dev/ui/pages/login/login_presenter.dart';

class LoginPage extends StatelessWidget {
  LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginPageHeader(theme: theme), 
            Headline1(text: 'Login'), 
            Padding(
              padding: const EdgeInsets.all(32),
              child: Form(child: 
                Column(
                  children: [
                    StreamBuilder<String?>(
                      stream: presenter.emailErrorStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            icon: Icon(Icons.email, color: theme.primaryColorLight),
                            errorText: snapshot.data?.isEmpty == true ? null : snapshot.data
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: presenter.validateEmail,
                        );
                      }
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top : 8, bottom: 32),
                      child: StreamBuilder<String?>(
                        stream: presenter.passwordErrorStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            decoration: InputDecoration(
                              labelText: "Senha",
                              icon: Icon(Icons.lock, color: theme.primaryColorLight),
                              errorText: snapshot.data?.isEmpty == true ? null : snapshot.data                              
                            ),
                            obscureText: true,
                            onChanged: presenter.validatePassword,
                          );
                        }
                      ),
                    ),
                    StreamBuilder<bool?>(
                      stream: presenter.isFormValidStream,
                      builder: (context, snapshot) {
                        return RaisedButton( 
                          onPressed: snapshot.data != true ? null : presenter.auth, 
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
            )
          ],
        ),
      ),
    );
  }
}

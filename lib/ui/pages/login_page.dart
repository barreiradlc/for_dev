import 'package:flutter/material.dart';
import 'package:for_dev/ui/components/headline1.dart';
import 'package:for_dev/ui/components/login/login_header.dart';

class LoginPage extends StatelessWidget {
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
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        icon: Icon(Icons.email, color: theme.primaryColorLight)
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top : 8, bottom: 32),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Senha",
                          icon: Icon(Icons.lock, color: theme.primaryColorLight)
                        ),
                        obscureText: true,
                      ),
                    ),
                    RaisedButton( 
                      onPressed: null, 
                      child: Text('Entrar')
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

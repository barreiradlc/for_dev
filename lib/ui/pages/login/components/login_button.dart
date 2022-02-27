import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:for_dev/ui/pages/login/login_presenter.dart';

class LoginButton extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    LoginPresenter presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<bool?>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return RaisedButton( 
          onPressed: snapshot.data != true ? null : presenter.auth, 
          child: Text('Entrar')
        );
      }
    );
  }
}



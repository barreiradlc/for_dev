import 'package:flutter/material.dart';
import 'package:for_dev/ui/pages/signup/signup_presenter.dart';
import 'package:for_dev/utils/i18n/resources.dart';
import 'package:provider/provider.dart';

import 'package:for_dev/ui/pages/login/login_presenter.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    

    SignUpPresenter presenter = Provider.of<SignUpPresenter>(context);

    return StreamBuilder<bool?>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return RaisedButton( 
          onPressed: snapshot.data != true ? null : presenter.signUp, 
          child: Text(R.strings.addAccount.toUpperCase())
        );
      }
    );
  }
}



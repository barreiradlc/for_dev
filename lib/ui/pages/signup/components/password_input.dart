import 'package:flutter/material.dart';
import 'package:for_dev/ui/pages/login/login_presenter.dart';
import 'package:for_dev/ui/pages/signup/signup_presenter.dart';
import 'package:provider/provider.dart';

class PasswordInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final presenter = Provider.of<SignUpPresenter>(context);

    return StreamBuilder<String?>(
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
      
    );
  }
}
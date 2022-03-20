import 'package:flutter/material.dart';
import 'package:for_dev/ui/pages/login/login_presenter.dart';
import 'package:for_dev/utils/i18n/resources.dart';
import 'package:provider/provider.dart';

class PasswordConfirmationInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return TextFormField(
      decoration: InputDecoration(
        labelText: R.strings.confirmPassword,
        icon: Icon(Icons.lock, color: theme.primaryColorLight),
      ),
      obscureText: true,          
    );
  }
}
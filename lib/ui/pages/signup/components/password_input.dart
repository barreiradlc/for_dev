import 'package:flutter/material.dart';
import 'package:for_dev/ui/pages/login/login_presenter.dart';
import 'package:provider/provider.dart';

class PasswordInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Senha",
        icon: Icon(Icons.lock, color: theme.primaryColorLight),
      ),
      obscureText: true,          
    );
  }
}
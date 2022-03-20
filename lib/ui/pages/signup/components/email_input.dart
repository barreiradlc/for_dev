import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:for_dev/ui/pages/login/login_presenter.dart';

class EmailInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
     
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        icon: Icon(Icons.email, color: theme.primaryColorLight),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:for_dev/ui/pages/signup/signup_presenter.dart';
import 'package:for_dev/utils/i18n/resources.dart';
import 'package:provider/provider.dart';

import 'package:for_dev/ui/pages/login/login_presenter.dart';

class NameInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final presenter = Provider.of<SignUpPresenter>(context);

    return StreamBuilder<String?>(
      stream: presenter.nameErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: "Nome",
            icon: Icon(Icons.person, color: theme.primaryColorLight),
            errorText: snapshot.data?.isEmpty == true ? null : snapshot.data
          ),
          keyboardType: TextInputType.name,
          onChanged: presenter.validateName,
        );
      }
      
    );
  }
}

import 'package:flutter/material.dart';
import 'package:for_dev/utils/i18n/resources.dart';
import 'package:provider/provider.dart';

import 'package:for_dev/ui/pages/login/login_presenter.dart';

class NameInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
 
    return TextFormField(
      decoration: InputDecoration(
        labelText: R.strings.name,
        icon: Icon(Icons.person, color: theme.primaryColorLight),        
      ),
      keyboardType: TextInputType.name,
    );
  }
}

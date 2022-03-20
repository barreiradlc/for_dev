import 'package:flutter/material.dart';
import 'package:for_dev/utils/i18n/resources.dart';
import 'package:provider/provider.dart';

import 'package:for_dev/ui/pages/login/login_presenter.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    
   return RaisedButton( 
      onPressed: null, 
      child: Text(R.strings.addAccount.toUpperCase())
  );
  }
}



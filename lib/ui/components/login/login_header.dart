import 'package:flutter/material.dart';

class LoginPageHeader extends StatelessWidget {
  const LoginPageHeader({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            theme.primaryColorLight,
            theme.primaryColorDark,
          ]
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            spreadRadius: 0,
            blurRadius: 4,
            color: Colors.black
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(80)
        )
      ),
      child: Image(
        image: AssetImage('lib/ui/assets/logo.png')
      )
    );
  }
}

import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, text) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red[900],
      content: Text(text, textAlign: TextAlign.center)
    )
  );
}
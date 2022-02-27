import 'package:flutter/material.dart';

void showLoadingSpinner(BuildContext context) {
  showDialog(
    context: context, 
    barrierDismissible: false,
    builder: (context) {
      return SimpleDialog(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text('Aguarde', textAlign: TextAlign.center)
            ]
          )
        ],
      );
    }
  );
}

void hideLoadingSpinner(BuildContext context) {
   if(Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
}
import 'package:flutter/material.dart';

import '../globals.dart';


void showSnackbar(String text) {
  snackbarKey.currentState
    ?..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
}
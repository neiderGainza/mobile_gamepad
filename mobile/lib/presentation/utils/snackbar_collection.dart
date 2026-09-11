import 'package:flutter/material.dart';

class SnackbarCollection {
  static _showSnackBar(BuildContext context, SnackBar snackBar)
    => ScaffoldMessenger.of(context).showSnackBar(snackBar);

  static void connectionFailedSnackbar(context) 
    => _showSnackBar(context, SnackBar(content: Text("Connection failed")));

}
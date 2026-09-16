import 'package:flutter/material.dart';
import 'package:game_controller/domain/model/connection_message.dart';

class SnackbarCollection {
  static _showSnackBar(BuildContext context, SnackBar snackBar)
    => ScaffoldMessenger.of(context).showSnackBar(snackBar);

  static void connectionFailedSnackbar(context) 
    => _showSnackBar(context, SnackBar(content: Text("Connection failed")));


  static void errorSnackbar(context, String error)
    => _showSnackBar(context, SnackBar(
      content: Text(error,)
    ));

  static void messageSnackbar(context, String message)
    => _showSnackBar(context, SnackBar(
      content: Text(message,)
    ));

  static void warningSnackbar(context, String warning)
    => _showSnackBar(context, SnackBar(
      content: Text(warning,)
    ));

  static void showConnectionMessage(context, ConnectionMessage message){
    return switch(message.type){
      .message => messageSnackbar(context, message.content),
      .warning => warningSnackbar(context, message.content),
      .error   => errorSnackbar(context, message.content),
    };
  }
}
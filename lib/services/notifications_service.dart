import 'package:flutter/material.dart';

class NotificacionsService{

  static GlobalKey<ScaffoldMessengerState> messengerKey =  new GlobalKey<ScaffoldMessengerState>();

  static showSnackError( String mensaje ){

      final snackBar = new SnackBar(
        backgroundColor: Colors.red.withOpacity(0.9),
        content: Text( mensaje, style: TextStyle( color: Colors.white, fontSize: 20 ) )
      );

      messengerKey.currentState!.showSnackBar(snackBar);
      
  }


  static showSnack( String mensaje ){
      final snackBar = new SnackBar(
        content: Text( mensaje, style: TextStyle( color: Colors.white, fontSize: 20 ) )
      );
      messengerKey.currentState!.showSnackBar(snackBar);
  }

}
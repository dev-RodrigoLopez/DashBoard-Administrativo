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

  static showBusyIndicator( BuildContext context ){

    final AlertDialog dialog = AlertDialog(
      content: Container(
        width: 100,
        height: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

    showDialog(context: context, builder: ( _ ) => dialog);

  }

}
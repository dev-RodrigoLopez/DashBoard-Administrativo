import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();


  String email    = '';
  String password = '';
  String nombre   = '';

   validateForm(){

    if( formKey.currentState!.validate() ){
      print('Form valid ...Login' );
      return true;
    }
    else{
      print('Form no valido');
      return false;
    }

  }


}
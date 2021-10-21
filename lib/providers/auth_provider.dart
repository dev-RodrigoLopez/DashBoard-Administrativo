import 'package:admin_dashboard/models/usuario.dart';
import 'package:flutter/cupertino.dart';

import 'package:admin_dashboard/api/flutter_web_api.dart';

import 'package:admin_dashboard/routes/router.dart';

import 'package:admin_dashboard/services/local_storege.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/services/navigation_servide.dart';

import 'package:admin_dashboard/models/http/authresponse.dart';

enum AuthStatus{
  cheking,
  authenticated,
  notAuthenticated
}

class AuthProvider extends ChangeNotifier{

  String? _token;
  AuthStatus authStatus = AuthStatus.cheking;
  Usuario? user;

  AuthProvider(){
    this.isAutenticated();
  }

  login( String email, String password ){

   final data = {
      'correo': email,
      'password': password
    };

    FlutterWebApi.post('/auth/login', data).then(
      (json){
        print(json);
        final authResponse = AuthResponse.fromMap(json);
        this.user = authResponse.usuario;

        authStatus = AuthStatus.authenticated;
        LocalStorage.prefs.setString( 'token', authResponse.token );
        NavigationService.replaceTo(Flurorouter.dashboardRoute);

        FlutterWebApi.configureDio;

        notifyListeners();

      }
      
    ).catchError((e){
      print('Error en $e');
      NotificacionsService.showSnackError('Usuario / Password no validos');
    });

  }



  register( String email, String password, String name ){

    final data = {
      'nombre': name,
      'correo': email,
      'password': password
    };

    FlutterWebApi.post('/usuarios', data).then(
      (json){
        print(json);
        final authResponse = AuthResponse.fromMap(json);
        this.user = authResponse.usuario;

        authStatus = AuthStatus.authenticated;
        LocalStorage.prefs.setString( 'token', authResponse.token );
        NavigationService.replaceTo(Flurorouter.dashboardRoute);

        FlutterWebApi.configureDio;

        notifyListeners();

      }
      
    ).catchError((e){
      print('Error en $e');
      NotificacionsService.showSnackError('Usuario / Password no validos');
    });

  }

  Future<bool> isAutenticated()async{

    final token = LocalStorage.prefs.getString('token');

    if( token == null ){
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try{

      final response = await FlutterWebApi.httpGet('/auth');
      final authResponse = AuthResponse.fromMap(response);

      this.user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;


    }
    catch(e){
      print(e);
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }


  logout(){
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }

}



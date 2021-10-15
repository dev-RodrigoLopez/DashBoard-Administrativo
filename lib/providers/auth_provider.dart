import 'package:admin_dashboard/models/http/authresponse.dart';
import 'package:flutter/cupertino.dart';

import 'package:admin_dashboard/api/flutter_web_api.dart';

import 'package:admin_dashboard/routes/router.dart';

import 'package:admin_dashboard/services/local_storege.dart';
import 'package:admin_dashboard/services/navigation_servide.dart';

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

    //TODO:PEticion http
    _token = 'abcdefjhijklmno';
    print('Almacenar JWT');
    LocalStorage.prefs.setString( 'token', this._token! );

    authStatus = AuthStatus.authenticated;
    notifyListeners();

    NavigationService.replaceTo(Flurorouter.dashboardRoute);

    // isAutenticated();

  }

  Future<bool> isAutenticated()async{

    final token = LocalStorage.prefs.getString('token');

    if( token == null ){
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    //TODO: Ir al backend y comprobar si el JWT es válido

    await Future.delayed(Duration( milliseconds: 1000 ));

    authStatus = AuthStatus.authenticated;
    notifyListeners();
    return true;

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
        notifyListeners();

      }
      
    ).catchError((e){
      print('Error en $e');
      //TODO: Mostrar notificacion de error
    });


  }

}



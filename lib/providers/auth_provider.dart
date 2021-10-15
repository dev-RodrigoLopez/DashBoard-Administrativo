import 'package:admin_dashboard/routes/router.dart';
import 'package:admin_dashboard/services/local_storege.dart';
import 'package:admin_dashboard/services/navigation_servide.dart';
import 'package:flutter/cupertino.dart';

enum AuthStatus{
  cheking,
  authenticated,
  notAuthenticated
}

class AuthProvider extends ChangeNotifier{

  String? _token;
  AuthStatus authStatus = AuthStatus.cheking;

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

}



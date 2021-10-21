import 'package:admin_dashboard/models/http/users_response.dart';
import 'package:flutter/cupertino.dart';

import 'package:admin_dashboard/api/flutter_web_api.dart';

import 'package:admin_dashboard/models/usuario.dart';

class UsersProvider extends ChangeNotifier{

  List<Usuario> users = [];
  bool isLoading = true;
  bool asceding =  true;
  int? sortColumnIndex;

  UsersProvider(){
    this.getPaginatedUsers();
  }


  getPaginatedUsers() async{

    final resp = await FlutterWebApi.httpGet('/usuarios?limite=100&desde=0');
     final usersRespon = UsersResponse.fromMap(resp);

     this.users = [ ... usersRespon.usuarios ];


    isLoading = false;
    notifyListeners();
  }

  Future<Usuario?> getUsersByID( String uid ) async{

    try{
      final resp = await FlutterWebApi.httpGet('/usuarios/$uid');
      final user = Usuario.fromMap( resp );
      return user;
    }
    catch(e){
      print(e);
      return null;
    }
  }


  void sort<T>( Comparable<T> Function( Usuario user ) getField ){

    users.sort( (a,b){
      final aValue = getField( a );
      final bValue = getField( b );

      return asceding
      ?  Comparable.compare(aValue, bValue)
      :  Comparable.compare(bValue, aValue);
      
    } );

    asceding = !asceding;

    notifyListeners();
  }

  void refreshUser ( Usuario newUser){

    this.users = this.users.map(
      (user){
        if( user.uid == newUser.uid){
          user = newUser;
        }
        return user;
      }
    ).toList();
    notifyListeners();
  }


}
import 'package:flutter/cupertino.dart';

class NavigationService {

  static GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  static navigatoTo( String routeName ){
    return navigatorKey.currentState!.pushNamed(routeName);
  }

   static replaceTo( String routeName ){
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

}
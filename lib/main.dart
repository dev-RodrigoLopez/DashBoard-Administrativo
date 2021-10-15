import 'package:admin_dashboard/api/flutter_web_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';

import 'package:admin_dashboard/routes/router.dart';

import 'package:admin_dashboard/services/local_storege.dart';
import 'package:admin_dashboard/services/navigation_servide.dart';

import 'package:admin_dashboard/ui/layauts/auth/aurh_layout.dart';
import 'package:admin_dashboard/ui/layauts/dashboard/dashboard_layout.dart';
import 'package:admin_dashboard/ui/layauts/splash/splash_layout.dart';

void main() async{

  await LocalStorage.configurePrefs();
  FlutterWebApi.configureDio();
  Flurorouter.configureRoutes();
  runApp(AppState());

}

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: ( _ ) => AuthProvider(), lazy: false, ),
        ChangeNotifierProvider( create: ( _ ) => SideMenuPRovider(), lazy: false, )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin DashBoard',
     initialRoute: '/',
     onGenerateRoute: Flurorouter.router.generator,
     navigatorKey: NavigationService.navigatorKey,
     builder: ( context, child){

       final authProvider = Provider.of<AuthProvider>(context);
       if( authProvider.authStatus == AuthStatus.cheking ){
          return SplashLayout();
       }

       if( authProvider.authStatus == AuthStatus.authenticated ){
          return DashboardLayout( child: child! );
       }
       else{
          return AuthLayout( child: child! );
       }



       
     },
     theme: ThemeData.light().copyWith(
       scrollbarTheme: ScrollbarThemeData().copyWith(
         thumbColor: MaterialStateProperty.all(
           Colors.grey[700]
         )
       )
     ),
    );
  }
}
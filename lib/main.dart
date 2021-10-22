import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/providers.dart';

import 'package:admin_dashboard/api/flutter_web_api.dart';

import 'package:admin_dashboard/routes/router.dart';

import 'package:admin_dashboard/services/local_storege.dart';
import 'package:admin_dashboard/services/navigation_servide.dart';
import 'package:admin_dashboard/services/notifications_service.dart';

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
        ChangeNotifierProvider( create: ( _ ) => SideMenuPRovider(), lazy: false, ),
        ChangeNotifierProvider( create: ( _ ) => CategoriasProvider() ),
        ChangeNotifierProvider( create: ( _ ) => UsersProvider() ),
        ChangeNotifierProvider( create: ( _ ) => UserFormProvider() ),
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
     scaffoldMessengerKey: NotificacionsService.messengerKey,
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
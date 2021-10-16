import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/routes/router.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';

import 'package:admin_dashboard/ui/views/blank_view.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';
import 'package:admin_dashboard/ui/views/icons_view.dart';
import 'package:admin_dashboard/ui/views/categories_view.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';



class DashboardHandlers{
  static Handler dashboard = Handler(
    handlerFunc: ( context, params  ){
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuPRovider>(context, listen: false)
        .serCurrentPageURL( Flurorouter.dashboardRoute );

      if( authProvider.authStatus == AuthStatus.authenticated )
        return DashboardView();
      else  
        return LoginView();
    }
  );


  static Handler icons = Handler(
    handlerFunc: ( context, params  ){
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuPRovider>(context, listen: false)
        .serCurrentPageURL( Flurorouter.IconsRoute );

      if( authProvider.authStatus == AuthStatus.authenticated )
        return IconsView();
      else  
        return LoginView();
    }
  );

  static Handler blanc = Handler(
    handlerFunc: ( context, params  ){
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuPRovider>(context, listen: false)
        .serCurrentPageURL( Flurorouter.blanckRoute );

      if( authProvider.authStatus == AuthStatus.authenticated )
        return BlankView();
      else  
        return LoginView();
    }
  );


  static Handler categories = Handler(
    handlerFunc: ( context, params  ){
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuPRovider>(context, listen: false)
        .serCurrentPageURL( Flurorouter.categoriesRoute );

      if( authProvider.authStatus == AuthStatus.authenticated )
        return CategoriesView();
      else  
        return LoginView();
    }
  );



}
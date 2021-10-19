import 'dart:js';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/routes/router.dart';
import 'package:admin_dashboard/services/navigation_servide.dart';
import 'package:admin_dashboard/ui/shared/widgets/logo.dart';
import 'package:admin_dashboard/ui/shared/widgets/menu_item.dart';
import 'package:admin_dashboard/ui/shared/widgets/textSeparator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Sidebar extends StatelessWidget {

  void navigateTo( String routeName){
    NavigationService.replaceTo( routeName );
    SideMenuPRovider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {

    final sideMenuProvider = Provider.of<SideMenuPRovider>(context);

    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [

          Logo(),
          SizedBox( height: 50 ),
          TextSeparator( text: 'main' ),  
          MenuItem(
            isActive: sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
            text: 'Dashboard',
            icon: Icons.compass_calibration_outlined,
            onPressed: () {
             navigateTo( Flurorouter.dashboardRoute );
            }
          ),

          MenuItem( text: 'Orders', icon: Icons.shopping_cart_outlined, isActive: false, onPressed: (){} ),
          MenuItem( text: 'Analitic', icon: Icons.show_chart_outlined, isActive: false, onPressed: (){} ),
          MenuItem( 
            text: 'Categories', 
            icon: Icons.layers_clear_outlined, 
            isActive: sideMenuProvider.currentPage == Flurorouter.categoriesRoute,
            onPressed: (){
               navigateTo( Flurorouter.categoriesRoute );
            } 
          ),
          MenuItem( text: 'Products', icon: Icons.dashboard_customize_outlined, isActive: false, onPressed: (){} ),
          MenuItem( text: 'Discount', icon: Icons.attach_email_outlined, isActive: false, onPressed: (){} ),
          MenuItem( text: 'Customers', icon: Icons.people_alt_outlined, isActive: false, onPressed: (){} ),

          SizedBox( height: 30 ),
          TextSeparator( text: 'UI Elements' ),  
          MenuItem( 
            isActive: sideMenuProvider.currentPage == Flurorouter.IconsRoute,
            text: 'Icons', 
            icon: Icons.list_alt_outlined, 
            onPressed: (){
              navigateTo( Flurorouter.IconsRoute );
            } 
          ),
          MenuItem( text: 'Marketing', icon: Icons.mark_email_read_outlined, isActive: false, onPressed: (){} ),
          MenuItem( text: 'Campaing', icon: Icons.note_add_outlined, isActive: false, onPressed: (){} ),
          MenuItem( 
            isActive: sideMenuProvider.currentPage == Flurorouter.blanckRoute, 
            text: 'Blank Page', 
            icon: Icons.dashboard_customize_outlined, 
            onPressed: (){
              navigateTo( Flurorouter.blanckRoute );
            } 
          ),
          
           SizedBox( height: 50 ),
          TextSeparator( text: 'Exit' ),  
          MenuItem( 
            text: 'Logout', 
            icon: Icons.exit_to_app_outlined, 
            isActive: false, 
            onPressed: (){
              Provider.of<AuthProvider>(context, listen: false).logout();
            } ),          

        ],
      ),
    );
  }

  BoxDecoration buildDecoration() => BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xff092044),
        Color(0xff092043),
      ]
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10
      )
    ]
  );
}
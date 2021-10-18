import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/ui/shared/navbar.dart';
import 'package:admin_dashboard/ui/shared/sidebar.dart';
import 'package:flutter/material.dart';


class DashboardLayout extends StatefulWidget {

  final Widget child;

  const DashboardLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    SideMenuPRovider.menuController = new AnimationController(vsync: this, duration: Duration( milliseconds: 300 ));
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of( context ).size;

    return Scaffold(
      backgroundColor: Color( 0xffEDf1f2 ),
      body: Stack(
        children: [
          Row(
            children: [
                
              //TOOO: Esto depende si la pantalla es mayor a 700
              if( size.width >= 700 )
                Sidebar(),

              Expanded(
                child: Column(
                  children: [
                    //Navbar
                    Navbar(),

                    //Contenedor de nuestro view
                    Expanded(
                      child: Container(
                        // padding: EdgeInsets.symmetric(  horizontal: 20, vertical: 10 ),
                        child:  widget.child,
                      )
                    )
                  ],
                ),
              )

             
            ],
          ),

          if( size.width < 700 )
            AnimatedBuilder(
              animation: SideMenuPRovider.menuController, 
              builder: ( context, _ ) => Stack(
                children: [
                  
                  if( SideMenuPRovider.isOpen )
                    Opacity(
                      opacity: SideMenuPRovider.opacity.value, 
                      child: GestureDetector(
                        onTap: () => SideMenuPRovider.closeMenu(),
                        child: Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.black26,
                        ),
                      ),
                    ),


                  Transform.translate(
                    offset: Offset( SideMenuPRovider.movement.value, 0 ),
                    child: Sidebar(),
                  )
                ],
              ))

        ],
      )
    );
  }
}
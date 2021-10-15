import 'dart:js';

import 'package:admin_dashboard/ui/buttons/links_bar.dart';
import 'package:admin_dashboard/ui/layauts/auth/widgets/background_twiter.dart';
import 'package:admin_dashboard/ui/layauts/auth/widgets/custom_tittle.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {

  final Widget child;

  const AuthLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Scrollbar(
        // isAlwaysShown: true,
        
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
      
            ( size.width > 1000 )
              ? _DesktopBody( child: child )
              : _MobileBody( child: child ),
      
            //Linksbar
            LinksBar()
      
          ],
        ),
      )
    );
  }
}


class _DesktopBody extends StatelessWidget {

  final Widget child;

  const _DesktopBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container( 
      
      width: size.width ,
      height: size.height * 0.95,
      // color: Colors.red,
      child: Row(
        children: [

          Expanded(child: BackgroundTwitter()),

          //view Container
          Container(
            width: 600,
            height: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                CustomTitle(),
                SizedBox( height: 50 ),
                Expanded(
                  child: child
                )
              ],
            ),
          )
          
        ],
      ),

    );
  }
}



class _MobileBody extends StatelessWidget {

  final Widget child;

  const _MobileBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox( height: 20),
          CustomTitle(),
          Container(
            width: double.infinity,
            height: 400,
            child: child,
          ),
          Container(
            width: double.infinity,
            height: 400,
            child: BackgroundTwitter(),
          )
        ],

      ),
    );
  }
}
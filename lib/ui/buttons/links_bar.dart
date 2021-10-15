import 'package:admin_dashboard/ui/buttons/links_text.dart';
import 'package:flutter/material.dart';

class LinksBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.black,
      height: ( size.width >1000 ) ? size.height * 0.05 : null,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: const [
          LinkText( texto: 'about' ),
          LinkText( texto: 'Help Center' ),
          LinkText( texto: 'Terms of Service' ),
          LinkText( texto: 'Privacy Policy' ),
          LinkText( texto: 'Cookie Policy' ),
          LinkText( texto: 'Ads info' ),
          LinkText( texto: 'Blog' ),
          LinkText( texto: 'careers' ),
          LinkText( texto: 'Brand Resources' ),
          LinkText( texto: 'Marketing' ),
        ],
      )
    );
  }
}
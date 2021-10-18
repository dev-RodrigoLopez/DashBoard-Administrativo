import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_label.dart';
import 'package:flutter/material.dart';


class IconsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(  horizontal: 20, vertical: 10 ),
      child: Center(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Text( 'Icons', style: CustomLabels.h1, ),
            
            SizedBox( height: 10 ),

            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              children: [
                WhiteCard(
                  width: 170,
                  title: 'ac_unit_outlined',
                  child: Center( child: Icon( Icons.ac_unit_outlined ) ),
                ), 

                 WhiteCard(
                  width: 170,
                  title: 'usb_rounded',
                  child: Center( child: Icon( Icons.usb_rounded ) ),
                ),

                 WhiteCard(
                  width: 170,
                  title: 'access_alarm',
                  child: Center( child: Icon( Icons.access_alarm ) ),
                ),

                 WhiteCard(
                  width: 170,
                  title: 'usb_off',
                  child: Center( child: Icon( Icons.usb_off ) ),
                ),

                 WhiteCard(
                  width: 170,
                  title: 'smart_display',
                  child: Center( child: Icon( Icons.smart_display) ),
                ),

                 WhiteCard(
                  width: 170,
                  title: 'tv',
                  child: Center( child: Icon( Icons.tv ) ),
                ),

                 WhiteCard(
                  width: 170,
                  title: 'computer',
                  child: Center( child: Icon( Icons.computer ) ),
                ),

                 WhiteCard(
                  width: 170,
                  title: 'handyman_rounded',
                  child: Center( child: Icon( Icons.handyman_rounded ) ),
                ),

                 WhiteCard(
                  width: 170,
                  title: 'no_encryption_gmailerrorred',
                  child: Center( child: Icon( Icons.no_encryption_gmailerrorred) ),
                ),
              ],
            )

           
          ],
        ),
      ),
    );
  }
}
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_label.dart';
import 'package:flutter/material.dart';


class BlankView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(  horizontal: 20, vertical: 10 ),
      child: Center(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Text( 'Blanc View', style: CustomLabels.h1, ),
            
            SizedBox( height: 10 ),

            WhiteCard(
              title: 'Sales Statistics',
              child: Text('Hola mundo')
            )
          ],
        ),
      ),
    );
  }
}
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_label.dart';
import 'package:flutter/material.dart';


class DashboardView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Text( 'Dashboar View', style: CustomLabels.h1, ),
            
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
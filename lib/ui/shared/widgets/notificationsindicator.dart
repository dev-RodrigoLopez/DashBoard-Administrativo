import 'package:flutter/material.dart';

class NoticationIndicator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton( icon: Icon( Icons.notifications_outlined ), onPressed: (){},),
        Positioned(
          left: 5,
          child: Container( 
            width: 5,
            height: 5,
            decoration: buildDecoration(),
           ),
        )
      ],
    );
  }

  BoxDecoration buildDecoration() => BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.circular(100)
  );
}
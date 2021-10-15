import 'package:flutter/material.dart';


class LinkText extends StatefulWidget {

  final String texto;
  final Function? onPressed;

  const LinkText({Key? key, required this.texto, this.onPressed}) : super(key: key);

  @override
  State<LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: ( _ ) => setState(() {
          isHover = true;
        }),
        onExit: ( _ ) => setState(() {
          isHover = false;
        }),
        child: Container(
          margin: const EdgeInsets.symmetric( horizontal: 10, vertical: 5 ),
          child: Text(
            widget.texto,
            style: TextStyle( 
              fontSize: 16,
              color: Colors.grey[700],
              decoration:  isHover ? TextDecoration.underline : TextDecoration.none
             ),
          ),
        ),
      ),onTap: (){

        if( widget.onPressed != null ){

          widget.onPressed!();

        }

      },
    );
  }
}
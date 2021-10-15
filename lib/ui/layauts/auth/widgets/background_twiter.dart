import 'package:flutter/material.dart';

class BackgroundTwitter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildBoxDecoration(),   
      child: Container(
        constraints: const BoxConstraints( maxWidth:400 ),
        child: const Center(
          child: Padding(
            padding: const EdgeInsets.symmetric( horizontal: 30  ),
            child: Image(
              image: AssetImage( 'twitter-bg.png' ),
              width: 400,
            ),
          ),
        ),
      ),     
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    image: DecorationImage(
      image: AssetImage('twitter-bg.png'),
      fit: BoxFit.cover
    )
  );
}
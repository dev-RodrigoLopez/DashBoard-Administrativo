import 'package:flutter/material.dart';


class NavbarAvatar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        child: Image.network('https://scontent.fmid2-1.fna.fbcdn.net/v/t1.6435-9/98596354_246045843504456_182912061452320768_n.jpg?_nc_cat=106&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeEWCh5qcj9PNRv-bqdFgB1FPTh8qISv0uI9OHyohK_S4i1sGSRLxXN_y9mUHEV4cRi9GdZTrlN424tYUA19AbNe&_nc_ohc=N5faY4HBpFkAX9uoA6F&_nc_ht=scontent.fmid2-1.fna&oh=e70013e644dbecb81a34ab1f5df29808&oe=618F1CD7'),
        width: 30,
        height: 30,
      ),
    );
  }
}
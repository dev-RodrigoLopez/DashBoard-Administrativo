import 'package:admin_dashboard/models/usuario.dart';
import 'package:admin_dashboard/services/navigation_servide.dart';
import 'package:flutter/material.dart';

class UsersDataSource extends DataTableSource{

  final List<Usuario> usuario;

  UsersDataSource(this.usuario);

  @override
  DataRow? getRow(int index) {

    final user = usuario[index];
    final image = ( user.img == null)
      ? Image( image: AssetImage('no-image.jpg'),  height: 35, width: 35)
      : FadeInImage.assetNetwork(placeholder: 'loader.gif', image: user.img!, height: 35, width: 35 );



    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( ClipOval(child: image) ),
        DataCell( Text( user.nombre )),
        DataCell( Text( user.correo )),
        DataCell( Text( user.uid )),
        DataCell( 
          IconButton(
            icon: Icon( Icons.edit_outlined ),
            onPressed: (){
              NavigationService.replaceTo( '/dashboard/users/${ user.uid }' );
            } 
          )
        ),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => usuario.length;

  @override
  int get selectedRowCount => 0;



}
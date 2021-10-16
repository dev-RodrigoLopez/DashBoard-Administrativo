import 'package:admin_dashboard/models/categoria.dart';
import 'package:flutter/material.dart';

class CategoriesDTS extends DataTableSource{

  final List<Categoria> categorias;

  CategoriesDTS(this.categorias);

  @override
  DataRow getRow(int index) {

    final categoria = this.categorias[index];
   
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Text( categoria.id ) ),
        DataCell( Text( categoria.nombre ) ),
        DataCell( Text( categoria.usuario.nombre ) ),
        DataCell( Row(
            children: [
              IconButton(
                onPressed: (){}, 
                icon: Icon( Icons.edit_outlined )
              ),
              IconButton(
                onPressed: (){}, 
                icon: Icon( Icons.delete_outline, color: Colors.red.withOpacity(0.6), )
              )
            ],
          ) 
        ),
      ]
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => categorias.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;



}
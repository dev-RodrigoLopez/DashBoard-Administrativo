import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:admin_dashboard/providers/categorias_provider.dart';

import 'package:admin_dashboard/models/categoria.dart';

import 'package:admin_dashboard/ui/modals/category_modal.dart';

class CategoriesDTS extends DataTableSource{

  final List<Categoria> categorias;
  final BuildContext context;

  CategoriesDTS(this.categorias, this.context);

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
                icon: Icon( Icons.edit_outlined ),
                onPressed: (){

                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context, 
                      builder: ( _ ) => CategoryModal( categoria: categoria )
                    );

                }, 
              ),
              IconButton(
                onPressed: (){


                  final dialog = AlertDialog(
                    title: Text('¿Estas seguro de borrarlo?'),
                    content: Text('¿Borrar definitivamente ${ categoria.nombre }?'),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, 
                        child: Text('No')
                      ),
                       TextButton(
                        onPressed: ()async{
                           await Provider.of<CategoriasProvider>(context, listen: false).deleteCategory(categoria.id);
                          Navigator.of(context).pop();
                        }, 
                        child: Text('SI')
                      ),
                    ],
                  );

                  showDialog(context: context, builder: ( _ ) => dialog );


                }, 
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
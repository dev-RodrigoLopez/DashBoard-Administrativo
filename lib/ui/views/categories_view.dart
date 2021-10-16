import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/ui/buttons/custom_icon_button.dart';
import 'package:admin_dashboard/ui/labels/custom_label.dart';

import 'package:admin_dashboard/datatable/categories_datasource.dart';

import 'package:admin_dashboard/providers/categorias_provider.dart';


class CategoriesView extends StatefulWidget {

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<CategoriasProvider>(context, listen: false).getCategorias() ;
  }


  @override
  Widget build(BuildContext context) {

    final categorias = Provider.of<CategoriasProvider>(context).categorias;

    return Container(
      child: Center(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Text( 'Categorias', style: CustomLabels.h1, ),
            
            SizedBox( height: 10 ),

            PaginatedDataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Categoria')),
                DataColumn(label: Text('Creado por')),
                DataColumn(label: Text('Acciones')),
              ], 
              source: CategoriesDTS( categorias ),
              header: Text('Esta es la lista de todas las categorías disponibles', maxLines: 2),
              rowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: (value){
                setState(() {
                  _rowsPerPage = value ?? 5;
                });
              },
              actions: [
                CustomIconButtom(
                  onPressed: (){},
                  text: 'Crear',
                  icon: Icons.add_outlined,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
import 'package:admin_dashboard/models/categoria.dart';
import 'package:admin_dashboard/providers/categorias_provider.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryModal extends StatefulWidget {

  final Categoria? categoria;

  const CategoryModal({
    Key? key, 
    this.categoria
  }) : super(key: key);

  @override
  State<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {

  String nombre = '';
  String? id;

  @override
  void initState() {
    super.initState();
    id = widget.categoria?.id;    
    id = widget.categoria?.nombre ?? '';    
  }


  @override
  Widget build(BuildContext context) {

    final categoriasProvider = Provider.of<CategoriasProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.all(20),
      height: 500,
      width: 300,
      decoration: buildDecoration(),
      child: Column(
        children: [


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( widget.categoria?.nombre ?? 'Nueva Categoría', style: CustomLabels.h1.copyWith( color: Colors.white ), ),
              IconButton(
                icon: Icon( Icons.close, color: Colors.white, ),
                onPressed: () => Navigator.of( context ).pop()
              )
            ],
          ),

          Divider( color: Colors.white.withOpacity(0.3) ),

          TextFormField(
            initialValue: widget.categoria?.nombre ?? '',
            onChanged: ( value ) => nombre = value,
            decoration: CustomInputs.loginInputDecoration(
              hint: 'Nombre de la categoria', 
              label: 'Categoria', 
              icon: Icons.new_releases_outlined
            ),
            style: TextStyle( color: Colors.white ),
          ),

          Container(
            margin: EdgeInsets.only( top:30 ),
            alignment: Alignment.center,
            child: CustomOutlineBotton(
              texto: 'Guardar',
              color: Colors.white,
              isTextWhite: true,
              onPressed: () async{

                if( id == "" )
                {
                  //crear
                  await categoriasProvider.newCategories( nombre );

                }
                else{
                  //ACtializar
                }

                Navigator.of(context).pop();

              }
            ),
          )


        ],
      ) ,
    );
  }

  BoxDecoration buildDecoration() => BoxDecoration(
    borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20) ),
    color: Color(0xff0F2041),
    boxShadow: [
      BoxShadow( color: Colors.black26 )
    ]
  );
}
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/models/usuario.dart';

import 'package:admin_dashboard/providers/users_form_provider.dart';
import 'package:admin_dashboard/providers/users_provider.dart';

import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_label.dart';

import 'package:admin_dashboard/services/navigation_servide.dart';
import 'package:admin_dashboard/services/notifications_service.dart';

class UserView extends StatefulWidget {

  final String uid;

  const UserView({
    Key? key, 
    required this.uid
  }) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {

  Usuario? user;

  @override
  void initState() {
    super.initState();
    final usersProvider = Provider.of<UsersProvider>( context, listen: false);
    final userFormProvider = Provider.of<UserFormProvider>( context, listen: false);

    usersProvider.getUsersByID( widget.uid )
      .then((userDB){
  
        if ( userDB != null){
          userFormProvider.user = userDB;
          userFormProvider.formKey  = new GlobalKey<FormState>();
          setState((){ this.user = userDB; });
        }
        else{
          NavigationService.replaceTo('/dashboard/users');
        }

      }
    );
  }


  @override
  void dispose() {
    this.user = null;
    Provider.of<UserFormProvider>( context, listen: false).user = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

   

    return Container(
      padding: EdgeInsets.symmetric(  horizontal: 20, vertical: 10 ),
      child: Center(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Text( 'User View', style: CustomLabels.h1, ),
            
            const SizedBox( height: 10 ),


            if( user ==  null )
              WhiteCard(
                child: Container(
                  height: 300,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ),

            if( user != null )
              _UserViewBody()

          ],
        ),
      ),
    );
  }
}

class _UserViewBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        columnWidths: {
          0: FixedColumnWidth(250)
        },

        children: [
          TableRow(
            children: [

              _AvatarContainer(),

               _UserViewForm(),

            ]
          )
        ],
      ),
    );
  }
}

class _UserViewForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;

    return WhiteCard(
      title: 'Informacion general ${ user.correo }',
      child: Form(
        key: userFormProvider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [

            TextFormField(
              initialValue: user.nombre,
              decoration: CustomInputs.FormInputDecoration(
                hint: 'Nombre del usuario', 
                label: 'Nombre', 
                icon: Icons.supervised_user_circle_outlined
              ),
              onChanged: ( value ) {
                user.nombre = value;
                userFormProvider.updateListener();
              }, 
              validator: ( value ){
                if( value == null || value.isEmpty) return 'Ingrese un nombre';
                if( value.length < 2 ) return 'El nombre debe de ser de dos letras como minimo';
                return null;

              },
            ),

            SizedBox( height: 20),

            TextFormField(
              initialValue: user.correo,
              decoration: CustomInputs.FormInputDecoration(
                hint: 'Correo del usuario', 
                label: 'Correo', 
                icon: Icons.mark_email_read_outlined
              ),
                onChanged: ( value ) => userFormProvider.copyUserWith( correo: value ),
                validator: ( value ){
                
                if( !EmailValidator.validate(value ?? '') ){
                  return 'Email no válido';
                }
                return null;

              },
            ),

            SizedBox( height: 20),

            ConstrainedBox(
              constraints: BoxConstraints( maxWidth: 130 ),
              child: ElevatedButton(
                onPressed: ()async{

                  final saved = await userFormProvider.updateUser();
                  if( saved ){
                    NotificacionsService.showSnack('Usuario actualizado');
                    Provider.of<UsersProvider>(context, listen: false).refreshUser( user );
                  }
                  else{
                    NotificacionsService.showSnackError('Error al actualizar');
                  }

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all( Colors.indigo ),
                  shadowColor: MaterialStateProperty.all( Colors.indigo )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Guardar'),
                    Icon( Icons.save_outlined ),
                  ],
                )
              ),
            )



          ],
        ),
      ),
    );
  }
}

class _AvatarContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserFormProvider>(context);
    final user = userProvider.user!;

    final image = ( user.img == null)
      ? Image( image: AssetImage('no-image.jpg'))
      : FadeInImage.assetNetwork(placeholder: 'loader.gif', image: user.img! );

    return WhiteCard(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Profile', style: CustomLabels.h2),
            SizedBox( height: 20, ),
            
            Container(
              width: 150,
              height: 160,
              child: Stack(
                children: [

                  ClipOval(
                    child: image
                  ),

                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        // color: Colors.red
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all( color: Colors.white, width: 5 )
                      ),
                      child: FloatingActionButton(
                        backgroundColor: Colors.indigo,
                        child: Icon( Icons.camera_alt_outlined, size: 20),
                        onPressed: () async{

                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            allowedExtensions: ['jpg', 'jpeg', 'png'],
                            allowMultiple: false
                            type: FileType.custom
                          );

                          if (result != null) {
                            PlatformFile file = result.files.first;

                            NotificacionsService.showBusyIndicator(context);

                            // print(file.name);
                            // print(file.bytes);
                            // print(file.size);
                            // print(file.extension);
                            final newUser = await userProvider.uploadImage('/uploads/usuarios/${ user.uid}', file.bytes!);
                            
                            Provider.of<UsersProvider>(context, listen: false).refreshUser(newUser);

                            Navigator.of(context).pop();

                          } else {
                            // User canceled the picker
                          }

                        },
                      )
                    ),
                  )

                ],
              ),
            ),

            SizedBox(
              height: 20,
            ), 

            Text(
              user.nombre, 
              style: TextStyle( fontWeight: FontWeight.bold ),
              textAlign: TextAlign.center,
            )

          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/register_form_provider.dart';

import 'package:admin_dashboard/routes/router.dart';

import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/buttons/links_text.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';

import 'package:email_validator/email_validator.dart';

class RegisterView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ( _ ) => RegisterFormProvider(),
      child: Builder(builder: (context){

        final registerformProvider = Provider.of<RegisterFormProvider>(context, listen: false);

        return  Container(
          // color: Colors.red,
          margin: const EdgeInsets.only( top: 30),
          padding: const EdgeInsets.symmetric( horizontal: 20 ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints( maxWidth: 370 ),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: registerformProvider.formKey,
                child: Column(
                  children: [

                    TextFormField(
                      onChanged: ( value ) => registerformProvider.nombre = value,
                      validator: ( value) {

                        if( value == null || value.isEmpty ) return 'El nombre es obligatorio';
                        return null;

                      },
                      style: const TextStyle( color: Colors.white ),
                      decoration: CustomInputs.loginInputDecoration(
                        hint: 'Ingrese su nombre',
                        label: 'nombre',
                        icon: Icons.person
                      ),
                    ),

                    SizedBox( height: 20 ),


                    TextFormField(
                      onChanged: ( value ) => registerformProvider.email = value,
                      validator: ( value ){
                        if( !EmailValidator.validate(value ?? '') ){
                          return 'Email no válido';
                        }
                        return null;
                      },
                      style: const TextStyle( color: Colors.white ),
                      decoration:  CustomInputs.loginInputDecoration(
                        hint: 'Ingrese su correo',
                        label: 'Email',
                        icon: Icons.email_outlined
                      ),
                    ),

                    SizedBox( height: 20 ),

                    TextFormField(
                      onChanged: ( value ) => registerformProvider.password = value,
                     validator: ( value ){
                        if( value == null || value.isEmpty ){
                          return 'Ingrese su contraseña';
                        }
                        if( value.length < 6  ){
                          return 'Su contraseña debe de ser 6 caracteres';
                        }
                      },
                      obscureText: true,
                      style: const TextStyle( color: Colors.white ),
                      decoration:  CustomInputs.loginInputDecoration(
                        hint: '**************',
                        label: 'Contraseña',
                        icon: Icons.lock_outline
                      ),
                    ),

                    const SizedBox( height: 20 ),

                    CustomOutlineBotton(
                      onPressed: (){
                        final validForm = registerformProvider.validateForm();

                        if( !validForm ) return;

                        //TODO: AuthProvider register
                        final authProvider = Provider.of<AuthProvider>(context, listen: false);
                        authProvider.register(
                          registerformProvider.email, 
                          registerformProvider.password, 
                          registerformProvider.nombre
                        );


                      },
                      texto: 'Crear cuenta',
                      isFilled: false,
                    ),

                    const SizedBox( height: 20 ),

                    LinkText(
                      texto: 'Ingresar',
                      onPressed: (){

                         Navigator.pushReplacementNamed(context, Flurorouter.registerRoute);

                      },
                    )


                  ],
                ),
              ),
            ),
          )
        );

      })
    );
  }

}
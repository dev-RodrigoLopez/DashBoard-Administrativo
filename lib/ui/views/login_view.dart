import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/login_form_provider.dart';
import 'package:admin_dashboard/routes/router.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/buttons/links_text.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return ChangeNotifierProvider(
      create: ( _ )=> LoginFormProvider(),
      child: Builder( builder: ( context ){

        final loginFormProvider = Provider.of<LoginFormProvider>(context, listen: false);

        return Container(
          // color: Colors.red,
          margin: const EdgeInsets.only( top: 100),
          padding: const EdgeInsets.symmetric( horizontal: 20 ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints( maxWidth: 370 ),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: loginFormProvider.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onFieldSubmitted: ( _ ) => onFormSubmit( loginFormProvider, authProvider ),
                      validator: ( value ){
                        if( !EmailValidator.validate(value ?? '') ){
                          return 'Email no válido';
                        }
                        return null;
                      },
                      onChanged: ( value ) => loginFormProvider.email = value,
                      style: const TextStyle( color: Colors.white ),
                      decoration:  CustomInputs.loginInputDecoration(
                        hint: 'Ingrese su correo',
                        label: 'Email',
                        icon: Icons.email_outlined
                      ),
                    ),
      
                    SizedBox( height: 20 ),
      
                    TextFormField(
                      onFieldSubmitted: ( _ ) => onFormSubmit( loginFormProvider, authProvider ),
                      onChanged: ( value ) => loginFormProvider.password = value,
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
                        onFormSubmit( loginFormProvider, authProvider );
                      },
                      texto: 'Ingresar',
                      isFilled: false,
                    ),
      
                    const SizedBox( height: 20 ),
      
                    LinkText(
                      texto: 'Nueva Cuenta',
                      onPressed: (){
                        


                        Navigator.pushNamed(context, Flurorouter.registerRoute);
      
                      },
                    )
      
      
                  ],
                ),
              ),
            ),
          )
        );

      } )
    );
  }

  void onFormSubmit( LoginFormProvider loginFormProvider, AuthProvider authProvider ){

    final isvalid = loginFormProvider.validateForm();
    if( isvalid )
    authProvider.login(loginFormProvider.email, loginFormProvider.password);


  }

}
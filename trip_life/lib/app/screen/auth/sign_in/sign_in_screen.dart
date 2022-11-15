import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_life/app/app_routes.dart';
import 'package:trip_life/app/modules/auth/bloc/auth_bloc.dart';
import 'package:trip_life/app/modules/form/email_validation.dart';
import 'package:trip_life/core/locator.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthBloc authBloc = locator<AuthBloc>();

  _signIn() {
    if (_formKey.currentState!.validate()) {
      authBloc.add(
          SignInRequested(_emailController.text, _passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: SingleChildScrollView(
              child: MultiBlocListener(
            listeners: [
              BlocListener<AuthBloc, AuthState>(listener: (context, state) {
                if (state is Authenticated) {
                  if (state.connectedTraveler != null) {
                    Navigator.pushReplacementNamed(context, tripListScreenRoute);
                  } else { 
                    Navigator.popAndPushNamed(context, createTravelerScreenRoute);
                  }
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              })
            ],
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SvgPicture.asset(
                    'trip.svg',
                    height: 30.h,
                  ),
                  SizedBox(height: 7.h),
                  Text("Connexion", textAlign: TextAlign.left, style: TextStyle(fontSize: 3.h),),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        suffixIcon: Icon(Icons.email_outlined)),
                    controller: _emailController,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return "Veuillez insérer votre email.";
                      }
                      if (!Validators.isEmailValid(email)) {
                        return "Format d'email invalide.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 1.h),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Mot de passe",
                        suffixIcon: Icon(Icons.lock_outline)),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return "Veuillez insérer votre mot de passe.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 2.h),
                  ElevatedButton(
                      onPressed: _signIn, child: const Text("Connexion")),
                  SizedBox(height: 2.h),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, signUpScreenRoute);
                      },
                      child: const Text("Pas encore de compte ? Créez-en un.")),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, splashScreenRoute);
                      },
                      child: const Text("Mot de passe oublié."))
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}

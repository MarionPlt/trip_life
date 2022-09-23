import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_life/app/app_routes.dart';
import 'package:trip_life/app/modules/auth/bloc/auth_bloc.dart';
import 'package:trip_life/app/modules/form/email_validation.dart';
import 'package:trip_life/core/locator.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthBloc authBloc = locator<AuthBloc>();

  _signUp() {
    if (_formKey.currentState!.validate()) {
      authBloc.add(
          SignUpRequested(_emailController.text, _passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inscrivez-vous")),
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: SingleChildScrollView(
            child: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(listener: (context, state) {
              if (state is Authenticated) {
                Navigator.pushReplacementNamed(context, tripListScreenRoute);
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }
            })
          ],
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/sign-in.svg',
                  height: 30.h,
                ),
                SizedBox(height: 7.h),
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
                    onPressed: _signUp, child: const Text("Valider")),
                SizedBox(height: 2.h),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, signInScreenRoute);
                    },
                    child: const Text("Déjà un compte ? Connectez-vous."))
              ],
            ),
          ),
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_life/app/app_routes.dart';
import 'package:trip_life/app/modules/auth/bloc/auth_bloc.dart';
import 'package:trip_life/app/modules/form/email_validation.dart';
import 'package:trip_life/app/modules/traveler/bloc/traveler_bloc.dart';
import 'package:trip_life/core/locator.dart';

class CreateTravelerScreen extends StatelessWidget {
  CreateTravelerScreen({Key? key}) : super(key: key);

  late String _id;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  final TravelerBloc travelerBloc = locator<TravelerBloc>();
  final AuthBloc authBloc = locator<AuthBloc>();

  createTravelerAccount() {
    if (_formKey.currentState!.validate()) {
      travelerBloc.add(CreateTravelerEvent(
          _id, _nameController.text, _emailController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            _id = state.userId;
            _emailController.text = state.email ?? '';
          } else {
            Navigator.pushReplacementNamed(context, signInScreenRoute);
          }
        },
        child: Scaffold(
          appBar: null,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(35),
              child: SingleChildScrollView(
                  child: MultiBlocListener(
                listeners: [
                  BlocListener<AuthBloc, AuthState>(listener: (context, state) {
                    if (state is Authenticated) {
                      Navigator.pushReplacementNamed(
                          context, tripListScreenRoute);
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
                        'sign_in.svg',
                        height: 30.h,
                      ),
                      SizedBox(height: 7.h),
                      Text(
                        "Cration de votre Traveler",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 3.h),
                      ),
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
                            labelText: "Pseudonyme",
                            suffixIcon: Icon(Icons.lock_outline)),
                        controller: _nameController,
                        obscureText: true,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "Veuillez insérer votre pseudonyme.";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 2.h),
                      ElevatedButton(
                          onPressed: () {
                            createTravelerAccount();
                          },
                          child: const Text("Valider")),
                      SizedBox(height: 2.h),
                      TextButton(
                          onPressed: () {
                            authBloc.add(SignOutRequested());
                          },
                          child: const Text("Annuler")),
                    ],
                  ),
                ),
              )),
            ),
          ),
        ));
  }
}

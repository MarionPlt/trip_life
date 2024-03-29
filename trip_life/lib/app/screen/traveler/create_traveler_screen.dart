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
  CreateTravelerScreen(this._id, this._email, {Key? key}) : super(key: key) {
    _emailController.text = _email ?? '';
  }

  final String _id;
  final String? _email;

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

  disconnect() {
    authBloc.add(SignOutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TravelerBloc, TravelerState>(listener: (context, state) {
          if (state is TravelerCreatedState) {
            authBloc.add(UpdateUserTraveler(state.traveler));
          }
        }),
        BlocListener<AuthBloc, AuthState>(listener: (context, state) {
          if (state is Authenticated) {
            if (state.connectedTraveler != null) {
              Navigator.pushReplacementNamed(context, tripListScreenRoute);
            }
          } else {
            authBloc.add(SignOutRequested());
          }
        })
      ],
      child: Scaffold(
        appBar: null,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: SingleChildScrollView(
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
                    "Création de votre Traveler",
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
                        suffixIcon: Icon(Icons.person)),
                    controller: _nameController,
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return "Veuillez insérer votre pseudonyme.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 2.h),
                  ElevatedButton(
                      onPressed: () => createTravelerAccount(),
                      child: const Text("Valider")),
                  SizedBox(height: 2.h),
                  TextButton(
                      onPressed: () => authBloc.add(SignOutRequested()),
                      child: const Text("Annuler")),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}

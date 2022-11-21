import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_life/app/app_routes.dart';
import 'package:trip_life/app/modules/auth/bloc/auth_bloc.dart';
import 'package:trip_life/app/modules/trip/bloc/trip_bloc.dart';
import 'package:trip_life/core/locator.dart';

class CreateTripScreen extends StatelessWidget {
  CreateTripScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TripBloc tripBloc = locator<TripBloc>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();

  _createTrip() {
    if (_formKey.currentState!.validate()) {
      tripBloc.add(CreateTripEvent(_titleController.text,
          _locationController.text, null, null, _notesController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Ajouter un voyage"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacementNamed(context, tripListScreenRoute);
              },
            )),
        body: Padding(
            padding: const EdgeInsets.all(35),
            child: SingleChildScrollView(
                child: MultiBlocListener(
                    listeners: [
                  BlocListener<AuthBloc, AuthState>(listener: (context, state) {
                    if (state is UnAuthenticated || state is AuthError) {
                      Navigator.pushReplacementNamed(
                          context, signInScreenRoute);
                    }
                  }),
                  BlocListener<TripBloc, TripState>(listener: (context, state) {
                    if (state is TripCreatedState) {
                      Navigator.pushReplacementNamed(
                          context, tripListScreenRoute);
                    }
                  }),
                ],
                    child: Form(
                        key: _formKey,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                decoration:
                                    const InputDecoration(labelText: 'Titre'),
                                controller: _titleController,
                                validator: (title) {
                                  if (title == null || title.isEmpty) {
                                    return "Veuillez saisir un titre pour ce voyage.";
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Localisation',
                                    suffixIcon: Icon(Icons.location_on)),
                                controller: _locationController,
                              ),
                              TextFormField(
                                decoration:
                                    const InputDecoration(labelText: 'Notes'),
                                controller: _notesController,
                              ),
                              SizedBox(height: 2.h),
                              ElevatedButton(
                                  onPressed: _createTrip,
                                  child: const Text("Valider"))
                            ]))))));
  }
}

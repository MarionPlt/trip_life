import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  _createTrip() {
    if (_formKey.currentState!.validate()) {
      final startDate = DateTime.parse(_startDateController.text);
      final endDate = DateTime.parse(_endDateController.text);
      tripBloc.add(CreateTripEvent(
          _titleController.text,
          _locationController.text,
          Timestamp.fromDate(startDate),
          Timestamp.fromDate(endDate),
          _notesController.text));
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
                      tripBloc.add(GetAllTripsEvent());
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
                                controller: _startDateController,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.calendar_today),
                                    labelText: "Date de début"),
                                onTap: () async {
                                  DateTime? date = DateTime(1900);
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100));

                                  if (date != null) {
                                    _startDateController.text =
                                        formatter.format(date);
                                  }
                                },
                                readOnly: true,
                              ),
                              TextFormField(
                                controller: _endDateController,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.calendar_today),
                                    labelText: "Date de fin"),
                                onTap: () async {
                                  DateTime? date = DateTime(1900);
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100));

                                  if (date != null) {
                                    _endDateController.text =
                                        formatter.format(date);
                                  }
                                },
                                readOnly: true,
                                validator: (value) {
                                  if (value != null) {
                                    var endDate = DateTime.parse(value);
                                    var startDate = DateTime.parse(
                                        _startDateController.text);
                                    if (endDate.isBefore(startDate)) {
                                      return "La date de fin doit être supérieur à la date de début.";
                                    }
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 20,
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

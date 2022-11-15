import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_life/app/app_routes.dart';
import 'package:trip_life/app/modules/auth/bloc/auth_bloc.dart';
import 'package:trip_life/app/modules/trip/bloc/trip_bloc.dart';
import 'package:trip_life/core/locator.dart';

class TripListScreen extends StatelessWidget {
  TripListScreen({Key? key}) : super(key: key);

  final TripBloc tripBloc = locator<TripBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated || state is AuthError) {
            Navigator.pushReplacementNamed(context, signInScreenRoute);
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Liste de voyages"),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, profileScreenRoute),
                ),
              ],
            ),
            body: BlocBuilder<TripBloc, TripState>(builder: (context, state) {
              if (state is TripListSuccessState) {
                if (state.trips.isNotEmpty) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: state.trips.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(state.trips[index].title ?? "",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                const SizedBox(height: 8),
                                Text(
                                  "Lieu: ${state.trips[index].location}",
                                  textAlign: TextAlign.left,
                                )
                              ]),
                        ));
                      });
                } else {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text("Aucun voyage enregistré.")],
                  ));
                }
              } else if (state is TripErrorState) {
                return const Text("Erreur lors du chargement des voyages.");
              }
              tripBloc.add(GetAllTripsEvent());
              return Center(
                  child: SizedBox(
                      height: 10.h,
                      width: 10.h,
                      child: const CircularProgressIndicator()));
            })));
  }
}

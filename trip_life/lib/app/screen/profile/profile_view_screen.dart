import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/app/app_routes.dart';
import 'package:trip_life/app/modules/auth/bloc/auth_bloc.dart';

class ProfileViewScreen extends StatelessWidget {
  const ProfileViewScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated || state is AuthError) {
            Navigator.pushReplacementNamed(context, signInScreenRoute);
          }
        },
        child: Scaffold(
            appBar: AppBar(
                elevation: 0.7,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, tripListScreenRoute);
                  },
                )),
            body: BlocBuilder<AuthBloc, AuthState>(
                builder: ((context, state) {
              if (state is Authenticated) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Image.asset(
                          '/images/avatar3.png',
                          height: 200,
                          width: 200,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Hi ${state.connectedTraveler!.name}",
                            style: const TextStyle(fontSize: 35),
                          )),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "email : ${state!.email}",
                            style: const TextStyle(fontSize: 20),
                          )),
                      const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "voyages enregistrés : 123",
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                );
              }
              return Container();
            }))));
  }
}

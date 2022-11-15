import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_routes.dart';
import '../../modules/auth/bloc/auth_bloc.dart';
import '../../modules/auth/data/repository/auth_repository.dart';

class ProfileViewScreen extends StatefulWidget {
  const ProfileViewScreen({Key? key}) : super(key: key);

  @override
  _ProfileViewScreenState createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  final AuthRepository authRepository = AuthRepository();
  late final String? emailUser;

  @override
  Widget build(BuildContext context) {
    emailUser = authRepository.getCurrentUser()?.email;

    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated || state is AuthError) {
            Navigator.pushReplacementNamed(context, signInScreenRoute);
          }
        },
        child: Scaffold(
            appBar: AppBar(
                elevation: 0.7,
                backgroundColor: Colors.blueGrey,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, tripListScreenRoute);
                  },
                )),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Image.asset(
                      '/images/avatar3.png',
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Hi there!",
                        style: TextStyle(fontSize: 35),
                      )),
                ),
                Center(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "email : $emailUser",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                Center(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "voyages enregistrés : 123",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ],
            )));
  }
}

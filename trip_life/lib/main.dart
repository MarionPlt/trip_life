import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_life/app/app_routes.dart';
import 'package:trip_life/app/modules/auth/bloc/auth_bloc.dart';
import 'package:trip_life/app/screen/auth/sign_in/sign_in_screen.dart';
import 'package:trip_life/app/screen/splash/splash_screen.dart';
import 'package:trip_life/core/locator.dart';
import 'app/modules/trip/bloc/trip_bloc.dart';
import 'app/screen/trip/trip_list.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final authBloc = locator<AuthBloc>();
  final tripBloc = locator<TripBloc>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Trip Life',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: routes,
        builder: (_, widget) {
          return MultiBlocProvider(providers: [
            BlocProvider<AuthBloc>(create: (_) => authBloc),
            BlocProvider<TripBloc>(create: (_) => tripBloc)
          ], child: widget ?? Container());
        },
        home: FutureBuilder<User?>(
            future: FirebaseAuth.instance.authStateChanges().first,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  //home
                  return TripListScreen();
                }
                //login
                return SignInScreen();
              }
              //splash
              return const SplashScreen();
            }),
      );
    });
  }
}

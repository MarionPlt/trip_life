import 'package:flutter/material.dart';
import 'package:trip_life/app/screen/auth/sign_in/sign_in_screen.dart';
import 'package:trip_life/app/screen/auth/sign_up/sign_up_screen.dart';
import 'package:trip_life/app/screen/profile/profile_view_screen.dart';
import 'package:trip_life/app/screen/splash/splash_screen.dart';
import 'package:trip_life/app/screen/trip/create_trip.dart';
import 'package:trip_life/app/screen/trip/trip_list.dart';

const createTripScreenRoute = '/create-trip';
const splashScreenRoute = '/splash';
const signInScreenRoute = '/signIn';
const signUpScreenRoute = '/signUp';
const tripListScreenRoute = '/trips';
const profileScreenRoute = '/profile';

Map<String, WidgetBuilder> routes = {
  createTripScreenRoute: (context) => CreateTripScreen(),
  splashScreenRoute: (context) => const SplashScreen(),
  tripListScreenRoute: (context) => TripListScreen(),
  signInScreenRoute: (context) => SignInScreen(),
  signUpScreenRoute: (context) => SignUpScreen(),
  profileScreenRoute: (context) => ProfileViewScreen()
};

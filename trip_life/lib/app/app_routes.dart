import 'package:flutter/material.dart';
import 'package:trip_life/app/screen/auth/sign_in/sign_in_screen.dart';
import 'package:trip_life/app/screen/auth/sign_up/sign_up_screen.dart';
import 'package:trip_life/app/screen/splash/splash_screen.dart';

const splashScreenRoute = '/splash';
const signInScreenRoute = '/signIn';
const signUpScreenRoute = '/signUp';

Map<String, WidgetBuilder> routes = {
  splashScreenRoute: (context) => const SplashScreen(),
  signInScreenRoute: (context) => SignInScreen(),
  signUpScreenRoute: (context) => SignUpScreen()
};

import 'package:get_it/get_it.dart';
import 'package:trip_life/app/modules/auth/bloc/auth_bloc.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<AuthBloc>(() => AuthBloc());
}

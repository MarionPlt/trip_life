import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/app/modules/auth/data/repository/auth_repository.dart';
import 'package:trip_life/app/modules/traveler/data/model/traveler.dart';
import 'package:trip_life/app/modules/traveler/data/repository/traveler_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = AuthRepository();
  final TravelerRepository travelerRepository = TravelerRepository();

  AuthBloc() : super(UnAuthenticated()) {
    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try {
        var connectedUser =
            await authRepository.login(event.email, event.password);
        var userId = connectedUser.user!.uid;
        var connectedTraveler = await travelerRepository.get(userId);
        emit(Authenticated(
            userId, connectedUser.user?.email, connectedTraveler));
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        var connectedUser = await authRepository.register(
            email: event.email, password: event.password);
        emit(Authenticated(
            connectedUser.user!.uid, connectedUser.user?.email, null));
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.disconnect();
      emit(UnAuthenticated());
    });

    on<ResetPasswordRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.resetPassword(email: event.email);
        emit(ResetPasswordMailSent());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<UpdateUserTraveler>(((event, emit) async {
      var connectedUser = authRepository.getCurrentUser();
      var userId = connectedUser!.uid;
      emit(Authenticated(userId, connectedUser.email!, event.traveler));
    }));
  }
}

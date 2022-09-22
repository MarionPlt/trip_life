import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/app/modules/auth/data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = AuthRepository();

  AuthBloc() : super(UnAuthenticated()) {
    
    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.login(event.email, event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.register(
            email: event.email, password: event.password);
        emit(Authenticated());
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
  }
}

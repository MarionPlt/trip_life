part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class Loading extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  final String userId;
  final String? email;
  final Traveler? connectedTraveler;

  Authenticated(this.userId, this.email, this.connectedTraveler);

  @override
  List<Object?> get props => [connectedTraveler];
}

 
class ResetPasswordMailSent extends AuthState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}

part of 'traveler_bloc.dart';

@immutable
abstract class TravelerState extends Equatable {}

class TravelerInitialState extends TravelerState {
  @override
  List<Object?> get props => [];
}

class TravelerLoadingState extends TravelerState {
  @override
  List<Object?> get props => [];
}

class TravelerCreatedState extends TravelerState {
  final Traveler traveler; 

  TravelerCreatedState(this.traveler);

  @override
  List<Object?> get props => [];
}

class TravelerLoadedState extends TravelerState {
  final Traveler traveler; 

  TravelerLoadedState(this.traveler);

  @override
  List<Object?> get props => [];
}

class TravelerErrorState extends TravelerState {
  final String error;

  TravelerErrorState(this.error);

  @override
  List<Object?> get props => [error];
} 
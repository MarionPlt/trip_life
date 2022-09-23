part of 'traveler_bloc.dart';

@immutable
abstract class TravelerState extends Equatable {}

class TravelerLoading extends TravelerState {
  @override
  List<Object?> get props => [];
}

class TravelerCreated extends TravelerState {
  final Traveler traveler; 

  TravelerCreated(this.traveler);

  @override
  List<Object?> get props => [];
}

class TravelerLoaded extends TravelerState {
  final Traveler traveler; 

  TravelerLoaded(this.traveler);

  @override
  List<Object?> get props => [];
}
part of 'trip_bloc.dart';

abstract class TripState extends Equatable {
  const TripState();
  
  @override
  List<Object> get props => [];
}

class InitialTripState extends TripState {
  @override
  List<Object> get props => [];
}

class TripCreatedState extends TripState {
  @override
  List<Object> get props => [];
}

class TripUpdatedState extends TripState {
  @override
  List<Object> get props => [];
}

class TripDeletedState extends TripState {
  @override
  List<Object> get props => [];
}

class TripLoadingState extends TripState {
  @override
  List<Object> get props => [];
}

class TripErrorState extends TripState {
  final String error;

  const TripErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class TripListSuccessState extends TripState {
  final List<Trip> trips;

  const TripListSuccessState(this.trips);

  @override
  List<Object> get props => [trips];
}
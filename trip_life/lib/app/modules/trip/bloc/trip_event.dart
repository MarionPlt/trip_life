part of 'trip_bloc.dart';

abstract class TripEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateTripEvent extends TripEvent {
  final Trip trip;

  CreateTripEvent(this.trip);
}

class UpdateTripEvent extends TripEvent {
  final Trip trip;

  UpdateTripEvent(this.trip);
}

class DeleteTripEvent extends TripEvent {
  final Trip trip;

  DeleteTripEvent(this.trip);
}

class GetAllTripsEvent extends TripEvent {
  @override
  List<Object> get props => [];
}
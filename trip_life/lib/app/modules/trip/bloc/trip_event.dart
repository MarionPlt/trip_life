part of 'trip_bloc.dart';

abstract class TripEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateTripEvent extends TripEvent {
  final String title;
  final String? location;
  final Timestamp? startDate;
  final Timestamp? endDate;
  final String? notes;

  CreateTripEvent(
      this.title, this.location, this.startDate, this.endDate, this.notes);
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

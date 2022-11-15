part of 'traveler_bloc.dart';

abstract class TravelerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateTravelerEvent extends TravelerEvent {
  final String userId;
  final String name;
  final String email;

  CreateTravelerEvent(this.userId, this.name, this.email);
}

class UpdateTravelerEvent extends TravelerEvent {
  final String name;
  final String email;

  UpdateTravelerEvent(this.name, this.email);
}


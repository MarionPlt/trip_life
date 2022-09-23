part of 'traveler_bloc.dart';

abstract class TravelerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateTraveler extends TravelerEvent {
  final String docId;
  final String name;
  final String email;

  CreateTraveler(this.docId, this.name, this.email);
}

class UpdateTraveler extends TravelerEvent {
  final String name;
  final String email;

  UpdateTraveler(this.name, this.email);
}
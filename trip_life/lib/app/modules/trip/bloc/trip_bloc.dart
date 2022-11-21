import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/app/modules/auth/data/repository/auth_repository.dart';
import 'package:trip_life/app/modules/traveler/data/model/traveler.dart';
import 'package:trip_life/app/modules/traveler/data/repository/traveler_repository.dart';
import 'package:trip_life/app/modules/trip/data/model/trip.dart';
import 'package:trip_life/app/modules/trip/data/repository/trip_repository.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripRepository tripRepository = TripRepository();
  final AuthRepository authRepository = AuthRepository();
  final TravelerRepository travelerRepository = TravelerRepository();

  TripBloc() : super(InitialTripState()) {
    on<CreateTripEvent>((event, emit) async {
      emit(TripLoadingState());
      try {
        Trip newTrip = Trip(
            id: '',
            title: event.title,
            startDate: event.startDate,
            endDate: event.endDate,
            location: event.location,
            notes: event.notes);

        User? user = authRepository.getCurrentUser();
        Traveler? traveler = await travelerRepository.get(user!.uid);
        newTrip.invitedUsers.add(traveler!);
        tripRepository.add(newTrip);

        emit(TripCreatedState());
      } catch (e) {
        emit(TripErrorState(e.toString()));
      }
    });

    on<UpdateTripEvent>((event, emit) async {
      try {
        await tripRepository.update(event.trip);
        emit(TripUpdatedState());
      } catch (e) {
        emit(TripErrorState(e.toString()));
      }
    });

    on<DeleteTripEvent>((event, emit) async {
      emit(TripLoadingState());
      try {
        await tripRepository.delete(event.trip);
        emit(TripDeletedState());
      } catch (e) {
        emit(TripErrorState(e.toString()));
      }
    });

    on<GetAllTripsEvent>((event, emit) async {
      try {
        var trips = await tripRepository.getTrips();
        emit(TripListSuccessState(trips));
      } catch (e) {
        emit(TripErrorState(e.toString()));
      }
    });
  }
}

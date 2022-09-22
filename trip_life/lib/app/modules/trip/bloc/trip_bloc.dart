import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/trip.dart';
import '../data/repository/trip_repository.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripRepository tripRepository = TripRepository();

  TripBloc() : super(InitialTripState()) {
    on<CreateTripEvent>((event, emit) async {
      emit(TripLoadingState());
      try {
        await tripRepository.add(event.trip);
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

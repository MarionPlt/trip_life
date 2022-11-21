import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/app/modules/traveler/data/model/traveler.dart';
import 'package:trip_life/app/modules/traveler/data/repository/traveler_repository.dart';

part 'traveler_event.dart';
part 'traveler_state.dart';

class TravelerBloc extends Bloc<TravelerEvent, TravelerState> {
  final TravelerRepository travelerRepository = TravelerRepository();

  TravelerBloc(): super(TravelerInitialState()) {
    on<CreateTravelerEvent>((event, emit) async {
      emit(TravelerLoadingState());
      try {
        var traveler = Traveler(event.userId, event.name, event.email);
        await travelerRepository.upsert(traveler); 
        emit(TravelerCreatedState(traveler));
      } catch (e) {
        emit(TravelerErrorState(e.toString()));
      }
    });
  }
}
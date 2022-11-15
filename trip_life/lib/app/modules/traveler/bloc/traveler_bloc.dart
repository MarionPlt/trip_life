import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/app/modules/traveler/data/model/traveler.dart';

part 'traveler_event.dart';
part 'traveler_state.dart';

class TravelerBloc extends Bloc<TravelerEvent, TravelerState> {
  TravelerBloc(): super(TravelerInitialState());
}
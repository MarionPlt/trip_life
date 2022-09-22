import 'dart:core';

import 'package:trip_life/app/modules/traveller/data/model/traveller.dart';

class Trip {
  final String id;
  String? title;
  String? startDate;
  String? endDate;
  String? location;
  String? notes;
  List<Traveller> members = [];

  Trip(
      {required this.id,
      this.title,
      this.startDate,
      this.endDate,
      this.location,
      this.notes});

  List<Traveller> get invitedUsers => members;

  Trip.fromJson(String tripId, Map<String, dynamic> json)
      : this(
            id: tripId,
            title: json['title'],
            startDate: json['startDate'],
            endDate: json['endDate'],
            location: json['location'],
            notes: json['notes']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'startDate': startDate,
        'endDate': endDate,
        'location': location,
        'notes': notes,
        'members': members
      };
}

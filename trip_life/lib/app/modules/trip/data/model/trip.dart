import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_life/app/modules/traveler/data/model/traveler.dart';

class Trip {
  String? id;
  String? title;
  Timestamp? startDate;
  Timestamp? endDate;
  String? location;
  String? notes;
  List<Traveler> members = [];

  Trip(
      {this.id,
      this.title,
      this.startDate,
      this.endDate,
      this.location,
      this.notes});

  List<Traveler> get invitedUsers => members;

  Trip.fromJson(String tripId, Map<String, dynamic> json)
      : this(
            id: tripId,
            title: json['title'],
            startDate: json['startDate'],
            endDate: json['endDate'],
            location: json['location'],
            notes: json['notes']);

  Map<String, dynamic> toJson() => {
        'title': title,
        'startDate': startDate,
        'endDate': endDate,
        'location': location,
        'notes': notes
      };
}

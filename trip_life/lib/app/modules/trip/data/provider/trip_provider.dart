import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/trip.dart';

class FirestoreTripProvider {
  String? _userId;

  final CollectionReference tripsRef =
      FirebaseFirestore.instance.collection("trips");

  Future addTrip(Trip trip) async {
    return tripsRef.add(trip.toJson());
  }

  Future<List<Trip>> getTrips() async {
    _userId = FirebaseAuth.instance.currentUser?.uid;
    var tripsCollection = await tripsRef.get();
    var trips = <Trip>[];

    for (var doc in tripsCollection.docs) {
      Trip trip = Trip.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      if (trip.members.contains((t) => t.id == _userId)) {
        trips.add(trip);
      }
    }

    return trips;
  }

  Future updateTrip(Trip trip) async {
    await tripsRef.doc().update(trip.toJson());
  }

  Future deleteTrip(Trip trip) async {
    await tripsRef.doc(trip.id).delete();
  }
}

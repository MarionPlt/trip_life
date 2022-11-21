import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_life/app/modules/traveler/data/model/traveler.dart';

class FirestoreTravelerProvider {
  final CollectionReference travelersRef =
      FirebaseFirestore.instance.collection("users");

  Future upsertTraveler(Traveler traveler) async {
    return travelersRef.doc(traveler.id).set(traveler.toJson());
  }

  Future<Traveler?> getTraveler(String travelerId) async {
    var doc = await travelersRef.doc(travelerId).get();
    if (doc.exists) {
      return Traveler.fromJson(doc.id, doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }
}

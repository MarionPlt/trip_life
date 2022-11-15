import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_life/app/modules/traveler/data/model/traveler.dart';

class FirestoreTravelerProvider {
  final CollectionReference travelersRef =
      FirebaseFirestore.instance.collection("users");

  Future addTraveler(Traveler traveler) async {
    return travelersRef.add(traveler.toJson());
  }

  Future updateTraveler(Traveler traveler) async {
    await travelersRef.doc(traveler.id).update(traveler.toJson());
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

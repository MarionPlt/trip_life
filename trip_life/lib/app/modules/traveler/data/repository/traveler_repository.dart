import 'package:trip_life/app/modules/traveler/data/model/traveler.dart';
import 'package:trip_life/app/modules/traveler/data/provider/traveler_provider.dart';


class TravelerRepository {
  final FirestoreTravelerProvider _provider = FirestoreTravelerProvider();
  
  upsert(Traveler traveler) async {
    await _provider.upsertTraveler(traveler);
  }

  Future<Traveler?> get(String travelerId) async {
    return await _provider.getTraveler(travelerId);
  } 
}
import 'package:trip_life/app/modules/traveler/data/model/traveler.dart';
import 'package:trip_life/app/modules/traveler/data/provider/traveler_provider.dart';


class TravelerRepository {
  final FirestoreTravelerProvider _provider = FirestoreTravelerProvider();

  add(Traveler traveler) async {
    await _provider.addTraveler(traveler);
  }

  update(Traveler traveler) async {
    await _provider.updateTraveler(traveler);
  }

  Future<Traveler?> get(String travelerId) async {
    return await _provider.getTraveler(travelerId);
  } 
}
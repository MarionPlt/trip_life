import '../model/trip.dart';
import '../provider/trip_provider.dart';

class TripRepository {
  final FirestoreTripProvider _provider = FirestoreTripProvider();

  add(Trip trip) async {
    await _provider.addTrip(trip);
  }

  update(Trip trip) async {
    await _provider.updateTrip(trip);
  }

  delete(Trip trip) async {
    await _provider.deleteTrip(trip);
  }

  Future<List<Trip>> getTrips() async {
    return await _provider.getTrips();
  }
}

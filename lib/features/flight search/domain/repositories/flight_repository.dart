import '../entities/flight.dart';

abstract class FlightRepository {
  Future<List<Flight>> searchFlights({
    required String departure,
    required String arrival,
    required DateTime date,
  });
}

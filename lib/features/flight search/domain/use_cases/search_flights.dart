import '../entities/flight.dart';
import '../repositories/flight_repository.dart';

class SearchFlights {
  final FlightRepository repository;

  SearchFlights(this.repository);

  Future<List<Flight>> execute({
    required String departure,
    required String arrival,
    required DateTime date,
  }) async {
    return await repository.searchFlights(
      departure: departure,
      arrival: arrival,
      date: date,
    );
  }
}

import 'package:flight_search_app/features/flight%20search/domain/entities/flight.dart';

class FlightModel extends Flight {
  FlightModel({
    required super.flightNumber,
    required super.airlineName,
    super.airlineIata,
    required super.departureAirport,
    required super.arrivalAirport,
    required super.departureIata,
    required super.arrivalIata,
    required super.departureTime,
    required super.arrivalTime,
    super.aircraft,
    required super.duration,
    required super.stops,
    required super.flightStatus,
    required super.flightDate,
  });

  factory FlightModel.fromJson(Map<String, dynamic> json) {
    final departure = json['departure'];
    final arrival = json['arrival'];
    final airline = json['airline'];
    final flight = json['flight'];

    final departureTime = DateTime.parse(
      departure['scheduled'] ??
          departure['estimated'] ??
          DateTime.now().toString(),
    );
    final arrivalTime = DateTime.parse(
      arrival['scheduled'] ??
          arrival['estimated'] ??
          DateTime.now().add(const Duration(hours: 2)).toString(),
    );

    return FlightModel(
      flightNumber: flight['number']?.toString() ?? 'N/A',
      airlineName: airline['name'] ?? 'Unknown Airline',
      airlineIata: airline['iata'],
      departureAirport: departure['airport'] ?? 'Unknown Airport',
      arrivalAirport: arrival['airport'] ?? 'Unknown Airport',
      departureIata: departure['iata'] ?? 'N/A',
      arrivalIata: arrival['iata'] ?? 'N/A',
      departureTime: departureTime,
      arrivalTime: arrivalTime,
      aircraft: json['aircraft']?['model'],
      duration: _calculateDuration(departureTime, arrivalTime),
      stops: 0, // AviationStack does not provide stops info
      flightStatus: json['flight_status'] ?? 'unknown',
      flightDate:
          json['flight_date'] ?? DateTime.now().toString().split(' ')[0],
    );
  }

  static String _calculateDuration(DateTime departure, DateTime arrival) {
    final difference = arrival.difference(departure);
    final hours = difference.inHours;
    final minutes = difference.inMinutes.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

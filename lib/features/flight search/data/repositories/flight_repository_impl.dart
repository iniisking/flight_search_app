import 'package:flight_search_app/core/network/dio_client.dart';
import 'package:flight_search_app/features/flight%20search/data/models/flight_model.dart';
import 'package:flight_search_app/features/flight%20search/domain/entities/flight.dart';
import 'package:flight_search_app/features/flight%20search/domain/repositories/flight_repository.dart';
import 'package:flutter/material.dart';

class FlightRepositoryImpl implements FlightRepository {
  final DioClient _dioClient;

  FlightRepositoryImpl(this._dioClient);

  @override
  Future<List<Flight>> searchFlights({
    required String departure,
    required String arrival,
    required DateTime date,
  }) async {
    try {
      final response = await _dioClient.get(
        '/flights',
        queryParameters: {
          'dep_iata': departure.toUpperCase(),
          'arr_iata': arrival.toUpperCase(),
          'flight_date': _formatDate(date),
          'limit': 50,
        },
      );

      final List<dynamic> data = response['data'] ?? [];

      if (data.isEmpty) {
        return [];
      }

      return data
          .map((flightJson) => FlightModel.fromJson(flightJson))
          .toList();
    } catch (e) {
      // Fallback to mock data if API fails
      debugPrint('API Error: $e');
      return _getMockFlights(departure, arrival, date);
    }
  }

  List<Flight> _getMockFlights(
    String departure,
    String arrival,
    DateTime date,
  ) {
    return [
      FlightModel(
        flightNumber: 'AA123',
        airlineName: 'American Airlines',
        airlineIata: 'AA',
        departureAirport: '$departure Airport',
        arrivalAirport: '$arrival Airport',
        departureIata: departure.toUpperCase(),
        arrivalIata: arrival.toUpperCase(),
        departureTime: date.add(const Duration(hours: 8)),
        arrivalTime: date.add(const Duration(hours: 10)),
        aircraft: 'Boeing 737',
        duration: '2h 0m',
        stops: 0,
        flightStatus: 'scheduled',
        flightDate: _formatDate(date),
      ),
      FlightModel(
        flightNumber: 'DL456',
        airlineName: 'Delta Air Lines',
        airlineIata: 'DL',
        departureAirport: '$departure Airport',
        arrivalAirport: '$arrival Airport',
        departureIata: departure.toUpperCase(),
        arrivalIata: arrival.toUpperCase(),
        departureTime: date.add(const Duration(hours: 12)),
        arrivalTime: date.add(const Duration(hours: 14, minutes: 30)),
        aircraft: 'Airbus A320',
        duration: '2h 30m',
        stops: 0,
        flightStatus: 'scheduled',
        flightDate: _formatDate(date),
      ),
      FlightModel(
        flightNumber: 'UA789',
        airlineName: 'United Airlines',
        airlineIata: 'UA',
        departureAirport: '$departure Airport',
        arrivalAirport: '$arrival Airport',
        departureIata: departure.toUpperCase(),
        arrivalIata: arrival.toUpperCase(),
        departureTime: date.add(const Duration(hours: 16)),
        arrivalTime: date.add(const Duration(hours: 19)),
        aircraft: 'Boeing 787',
        duration: '3h 0m',
        stops: 1,
        flightStatus: 'scheduled',
        flightDate: _formatDate(date),
      ),
    ];
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

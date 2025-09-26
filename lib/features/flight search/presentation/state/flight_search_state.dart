import 'package:flight_search_app/features/flight%20search/domain/entities/flight.dart';
import 'package:flight_search_app/features/flight%20search/domain/use_cases/search_flights.dart';
import 'package:flutter_riverpod/legacy.dart';

class FlightSearchState {
  final List<Flight> flights;
  final bool isLoading;
  final String? error;
  final String? departure;
  final String? arrival;
  final DateTime? date;
  final bool directFlightsOnly;
  final bool includeNearbyAirports;

  const FlightSearchState({
    this.flights = const [],
    this.isLoading = false,
    this.error,
    this.departure,
    this.arrival,
    this.date,
    this.directFlightsOnly = false,
    this.includeNearbyAirports = false,
  });

  FlightSearchState copyWith({
    List<Flight>? flights,
    bool? isLoading,
    String? error,
    String? departure,
    String? arrival,
    DateTime? date,
    bool? directFlightsOnly,
    bool? includeNearbyAirports,
  }) {
    return FlightSearchState(
      flights: flights ?? this.flights,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      departure: departure ?? this.departure,
      arrival: arrival ?? this.arrival,
      date: date ?? this.date,
      directFlightsOnly: directFlightsOnly ?? this.directFlightsOnly,
      includeNearbyAirports:
          includeNearbyAirports ?? this.includeNearbyAirports,
    );
  }
}

class FlightSearchNotifier extends StateNotifier<FlightSearchState> {
  final SearchFlights _searchFlights;

  FlightSearchNotifier(this._searchFlights) : super(const FlightSearchState());

  void setDeparture(String departure) {
    state = state.copyWith(departure: departure);
  }

  void setArrival(String arrival) {
    state = state.copyWith(arrival: arrival);
  }

  void setDate(DateTime date) {
    state = state.copyWith(date: date);
  }

  void setDirectFlightsOnly(bool directFlightsOnly) {
    state = state.copyWith(directFlightsOnly: directFlightsOnly);
  }

  void setIncludeNearbyAirports(bool includeNearbyAirports) {
    state = state.copyWith(includeNearbyAirports: includeNearbyAirports);
  }

  Future<void> searchFlights() async {
    if (state.departure == null ||
        state.arrival == null ||
        state.date == null) {
      state = state.copyWith(error: 'Please fill all fields');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final flights = await _searchFlights.execute(
        departure: state.departure!,
        arrival: state.arrival!,
        date: state.date!,
      );

      // Apply filters
      var filteredFlights = flights;
      if (state.directFlightsOnly) {
        filteredFlights = filteredFlights
            .where((flight) => flight.stops == 0)
            .toList();
      }

      state = state.copyWith(flights: filteredFlights, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearResults() {
    state = state.copyWith(flights: []);
  }
}

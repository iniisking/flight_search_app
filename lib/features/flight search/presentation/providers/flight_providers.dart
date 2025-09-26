import 'package:flight_search_app/features/flight%20search/data/repositories/flight_repository_impl.dart';
import 'package:flight_search_app/features/flight%20search/domain/repositories/flight_repository.dart';
import 'package:flight_search_app/features/flight%20search/domain/use_cases/search_flights.dart';
import 'package:flight_search_app/features/flight%20search/presentation/state/flight_search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flight_search_app/core/network/dio_client.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(baseUrl: dotenv.env['AVIATION_STACK_BASE_URL'] ?? '');
});

final flightRepositoryProvider = Provider<FlightRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return FlightRepositoryImpl(dioClient);
});

final searchFlightsUseCaseProvider = Provider<SearchFlights>((ref) {
  final repository = ref.watch(flightRepositoryProvider);
  return SearchFlights(repository);
});

final flightSearchNotifierProvider =
    StateNotifierProvider<FlightSearchNotifier, FlightSearchState>((ref) {
      final searchFlights = ref.watch(searchFlightsUseCaseProvider);
      return FlightSearchNotifier(searchFlights);
    });

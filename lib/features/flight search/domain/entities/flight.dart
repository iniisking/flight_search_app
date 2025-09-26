class Flight {
  final String flightNumber;
  final String airlineName;
  final String? airlineIata;
  final String departureAirport;
  final String arrivalAirport;
  final String departureIata;
  final String arrivalIata;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final String? aircraft;
  final String duration;
  final int stops;
  final String flightStatus;
  final String flightDate;

  const Flight({
    required this.flightNumber,
    required this.airlineName,
    this.airlineIata,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureIata,
    required this.arrivalIata,
    required this.departureTime,
    required this.arrivalTime,
    this.aircraft,
    required this.duration,
    required this.stops,
    required this.flightStatus,
    required this.flightDate,
  });

  String get formattedDepartureTime {
    return '${departureTime.hour.toString().padLeft(2, '0')}:${departureTime.minute.toString().padLeft(2, '0')}';
  }

  String get formattedArrivalTime {
    return '${arrivalTime.hour.toString().padLeft(2, '0')}:${arrivalTime.minute.toString().padLeft(2, '0')}';
  }

  String? get airlineLogo {
    if (airlineIata == null) return null;
    return 'https://images.kiwi.com/airlines/64/${airlineIata!.toUpperCase()}.png';
  }

  double get price {
    final basePrice = 150.0;
    final randomFactor = _generateStableRandom(flightNumber);
    return (basePrice * (0.8 + randomFactor * 0.4)).roundToDouble();
  }

  double _generateStableRandom(String seed) {
    var hash = 0;
    for (var i = 0; i < seed.length; i++) {
      hash = seed.codeUnitAt(i) + ((hash << 5) - hash);
    }
    return (hash % 1000) / 1000.0;
  }
}

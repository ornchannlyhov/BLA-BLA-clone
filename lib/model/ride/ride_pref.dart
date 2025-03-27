import '../location/locations.dart';

class RidePreference {
  final Location departure;
  final DateTime departureDate;
  final Location arrival;
  final int requestedSeats;

  const RidePreference({
    required this.departure,
    required this.departureDate,
    required this.arrival,
    required this.requestedSeats,
  });

  @override
  bool operator ==(Object other) {
    // identical use to check if the objects are from the same memory location jg hah
    if (identical(this, other)) return true;
    // is  is use to check if the object are the same type 
    return other is RidePreference &&
        departure == other.departure &&
        departureDate == other.departureDate &&
        arrival == other.arrival &&
        requestedSeats == other.requestedSeats;
  }

  @override
  int get hashCode {
    return Object.hash(
      departure,
      departureDate,
      arrival,
      requestedSeats,
    );
  }

  @override
  String toString() {
    return 'RidePref(departure: ${departure.name}, '
        'departureDate: ${departureDate.toIso8601String()}, '
        'arrival: ${arrival.name}, '
        'requestedSeats: $requestedSeats)';
  }
}

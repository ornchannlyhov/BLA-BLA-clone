import 'package:week_3_blabla_project/data/dto/location_dto.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

class RidePreferenceDto {

  static Map<String, dynamic> toJson(RidePreference ridePreference) {
    return {
      // "departure": ridePreference.departure,
      "departure": LocationDto.toJson(ridePreference.departure),
      "arrival": LocationDto.toJson(ridePreference.arrival),
      "departureDate": ridePreference.departureDate.toString(),
      "requestedSeats": ridePreference.requestedSeats
    };
  }

  static RidePreference fromJson(Map<String, dynamic> json) {
    return RidePreference(
        departure: LocationDto.fromJson(json['departure']),
        departureDate: DateTime.tryParse(json['departureDate'])!,
        arrival: LocationDto.fromJson(json['arrival']),
        requestedSeats: json['requestedSeats']);
  }
  

}

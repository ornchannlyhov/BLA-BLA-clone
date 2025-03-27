import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/web.dart';
import 'package:week_3_blabla_project/data/dto/location_dto.dart';
import 'package:week_3_blabla_project/data/repository/locations_repository.dart';
import 'package:week_3_blabla_project/model/location/locations.dart';

class LocationFirebaseRepository extends LocationsRepository {
  @override
  Future<List<Location>> getLocations() async {
    final DatabaseReference locationRef =
        FirebaseDatabase.instance.ref(); // Root node
    final DataSnapshot snapshot =
        await locationRef.once().then((event) => event.snapshot);

    if (snapshot.exists) {
      // Firebase returns a List<dynamic> in this case
      final data = snapshot.value;

      if (data is List) {
        // Convert the Firebase list to a list of Location objects
        List<Location> locations = data.asMap().entries.map((entry) {
          // Each entry.value is a Map containing a "data" key
          final entryData = entry.value as Map;
          if (entryData.containsKey('data')) {
            final locationData =
                Map<String, dynamic>.from(entryData['data'] as Map);
            return LocationDto.fromJson(locationData);
          } else {
            throw Exception(
                'Missing "data" key in entry at index: ${entry.key}');
          }
        }).toList();
        Logger().d('Firebase Location Fetch successfully');
        return locations;
      } else {
        print("Unexpected data format: $data");
        return [];
      }
    } else {
      print("No data available");
      return [];
    }
  }
}

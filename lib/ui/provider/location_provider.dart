import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/data/repository/locations_repository.dart';
import 'package:week_3_blabla_project/data/repository/mock/firebase/location_firebase_repository.dart';
import 'package:week_3_blabla_project/model/location/locations.dart';

class LocationProvider extends ChangeNotifier {
  LocationProvider();

  final LocationsRepository locationsRepository = LocationFirebaseRepository();

  List<Location> filteredLocations = [];


  Future<List<Location>> getLocationsFor(String text) async {
    final List<Location> locations = await locationsRepository.getLocations();
    return locations
        .where((location) =>
            location.name.toUpperCase().contains(text.toUpperCase()))
        .toList();
  }

  void onSearchChanged(String searchText) async {
    List<Location> newSelection = [];

    if (searchText.length > 1) {
      // We start to search from 2 characters only.
      newSelection = await getLocationsFor(searchText);
    }
    filteredLocations = newSelection;
    notifyListeners();
  }
}


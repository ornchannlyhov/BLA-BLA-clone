import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:week_3_blabla_project/data/repository/mock/local_storage/local_ride_preference_repository.dart';
import 'package:week_3_blabla_project/data/repository/ride_preferences_repository.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/ui/provider/async_value.dart';

class RidePrefProvider extends ChangeNotifier {
  RidePrefProvider() {
    fetchRidePreferences();
  }
  RidePreferencesRepository ridePreferencesRepository =
      LocalRidePreferenceRepository();
  // current pref is here
  RidePreference? _currentPreference;
  RidePreference? get currentPreference => _currentPreference;

  // past pref is here
  late AsyncValue<List<RidePreference>> pastPreferences;

  void setCurrentPreference(RidePreference ridePreference) async {
    if (_currentPreference == ridePreference) {
    } else {
      _currentPreference = ridePreference;
    }
    await ridePreferencesRepository.addPreference(_currentPreference!);
    fetchRidePreferences();
    notifyListeners();
  }

  void fetchRidePreferences() async {
    pastPreferences = AsyncValue.loading();
    notifyListeners();
    try {
    // 2 Fetch data
      List<RidePreference> pastPrefs =
          await ridePreferencesRepository.getPastPreferences();
    // 3 Handle success
      pastPreferences = AsyncValue.success(pastPrefs.reversed.toList());
      Logger().d('Past preferences fetched successfully');
      // Logger().d(pastPrefs.reversed.toList());
      // Logger().d(pastPrefs);
    // 4 Handle error
    } catch (error) {
      pastPreferences = AsyncValue.error(error);
    }
    notifyListeners();
  }
}

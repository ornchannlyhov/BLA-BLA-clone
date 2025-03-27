import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:week_3_blabla_project/data/dto/ride_preference_dto.dart';
import 'package:week_3_blabla_project/data/repository/ride_preferences_repository.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

class LocalRidePreferenceRepository extends RidePreferencesRepository {
  static const String _preferencesKey = "ride_preferences";
  // TODO: Update to future to return List of ridepref
  @override
  Future<List<RidePreference>> getPastPreferences() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final prefsList = pref.getStringList(_preferencesKey) ?? [];
    return prefsList
        .map((json) => RidePreferenceDto.fromJson(jsonDecode(json)))
        .toList();
  }

  // TODO: Update to future to add list of ride pref
  @override
  Future<void> addPreference(RidePreference pastRef) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final List<RidePreference> prefsList = await getPastPreferences();

    if (prefsList.isNotEmpty) {
      if (prefsList.contains(pastRef)) {
        prefsList.removeWhere(
          (pref) {
            return pref == pastRef;
          },
        );
      }
      prefsList.add(pastRef);
    }

    final List<String> jsonList = prefsList
        .map(
          (ridePref) => jsonEncode(RidePreferenceDto.toJson(ridePref)),
        )
        .toList();

    await pref.setStringList(_preferencesKey, jsonList);
  }
}

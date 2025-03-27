import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/ui/provider/ride_pref_provider.dart';
import 'package:week_3_blabla_project/ui/screens/rides/widgets/ride_pref_modal.dart';
import 'package:week_3_blabla_project/utils/animations_util.dart';
import '../../../model/ride/ride_filter.dart';
import 'widgets/ride_pref_bar.dart';

import '../../../model/ride/ride.dart';
import '../../../model/ride/ride_pref.dart';
import '../../../service/rides_service.dart';
import '../../theme/theme.dart';
import 'widgets/rides_tile.dart';
// // calling current pref

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///
class RidesScreen extends StatelessWidget {
  RidesScreen({super.key});

// RidePreference get currentPreference =>
//     RidePrefService.instance.currentPreference!;

// calling current filter
  final RideFilter currentFilter = RideFilter();

// get list of match ride after search
  List<Ride> matchingRides(RidePreference currentPreference) =>
      RidesService.instance.getRidesFor(currentPreference, currentFilter);

// just back button
  void onBackPressed(BuildContext context) {
    // 1 - Back to the previous view
    Navigator.of(context).pop();
  }

  void onRidePrefSelected(
      RidePreference newPreference, BuildContext context) async {
        
      }

  void onPreferencePressed(
      BuildContext context, RidePreference ridePref) async {
    // Open a modal to edit the ride preferences
    RidePreference? newPreference = await Navigator.of(
      context,
    ).push<RidePreference>(
      AnimationUtils.createTopToBottomRoute(
        RidePrefModal(initialPreference: ridePref),
      ),
    );

    if (newPreference != null) {
      // 1 - Update the current preference
      // RidePrefService.instance.setCurrentPreference(newPreference);
      context.read<RidePrefProvider>().setCurrentPreference(newPreference);

      //   // 2 -   Update the state   -- TODO MAKE IT WITH STATE MANAGEMENT

      // }
    }
  }

  void onFilterPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: BlaSpacings.m,
            right: BlaSpacings.m,
            top: BlaSpacings.s,
          ),
          child: Consumer<RidePrefProvider>(
            builder: (context, ridePref, child) => Column(
              children: [
                // Top search Search bar
                RidePrefBar(
                  ridePreference: ridePref.currentPreference!,
                  onBackPressed: () => onBackPressed(context),
                  onPreferencePressed: () =>
                      onPreferencePressed(context, ridePref.currentPreference!),
                  onFilterPressed: onFilterPressed,
                ),
        
                Expanded(
                  child: ListView.builder(
                    itemCount: matchingRides(ridePref.currentPreference!).length,
                    itemBuilder: (ctx, index) => RideTile(
                        ride: matchingRides(ridePref.currentPreference!)[index],
                        onPressed: () {}),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

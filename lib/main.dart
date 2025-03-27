import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/firebase_options.dart';
import 'package:week_3_blabla_project/ui/provider/location_provider.dart';
import 'package:week_3_blabla_project/ui/provider/ride_pref_provider.dart';
import 'data/repository/mock/mock_rides_repository.dart';
import 'service/rides_service.dart';

import 'ui/screens/ride_pref/ride_pref_screen.dart';
import 'ui/theme/theme.dart';

void main() async {
  // 1 - Initialize the services
  // RidePrefService.initialize(MockRidePreferencesRepository());
  // LocationsService.initialize(MockLocationsRepository());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  RidesService.initialize(MockRidesRepository());

  // 2- Run the UI
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RidePrefProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: Scaffold(body: RidePrefScreen()),
      ),
    );
  }
}

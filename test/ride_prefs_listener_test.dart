import 'dart:io';

import 'package:blablabla/listeners/ride_prefs_listener.dart';
import 'package:blablabla/model/ride_pref/ride_pref.dart';
import 'package:blablabla/repository/mock/mock_ride_preferences_repository.dart';
import 'package:blablabla/service/ride_prefs_service.dart';
import 'package:blablabla/dummy_data/dummy_data.dart';

class ConsoleLogger extends RidePrefsListener {
  @override
  void onPreferenceSelected(RidePreference selectedPreference) {
    print("ConsoleLogger: New preference $selectedPreference");
  }
}

void main() {
  RidePrefService.initialize(MockRidePreferencesRepository());
  
  ConsoleLogger logger = ConsoleLogger();
  RidePrefService.addListener(logger);

  RidePrefService.instance.setCurrentPreference(fakeRidePrefs[0]);
  sleep(const Duration(seconds: 1));
  RidePrefService.instance.setCurrentPreference(fakeRidePrefs[1]);
  sleep(const Duration(seconds: 1));
  RidePrefService.instance.setCurrentPreference(fakeRidePrefs[2]);
}
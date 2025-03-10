import 'package:blablabla/model/ride_pref/ride_pref.dart';

abstract class RidePrefsListener {
  void onPreferenceSelected(RidePreference selectedPreference);
}
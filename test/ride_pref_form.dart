import 'package:blablabla/model/ride/locations.dart';
import 'package:blablabla/model/ride_pref/ride_pref.dart';
import 'package:blablabla/screens/ride_pref/ride_pref_screen.dart';
import 'package:blablabla/service/ride_prefs_service.dart';
import 'package:flutter/material.dart';

RidePref pref_1 = RidePref(
  departure: Location(name: "Paris", country: Country.france),
  departureDate: DateTime.now(),
  arrival: Location(name: "Lyon", country: Country.france),
  requestedSeats: 1,
);

void main() {
  RidePrefService.currentRidePref = pref_1;
  runApp(MaterialApp(home: Scaffold(body: RidePrefScreen())));
}

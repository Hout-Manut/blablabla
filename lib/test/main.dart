import 'package:blablabla/model/ride/ride.dart';
import 'package:blablabla/dummy_data/dummy_data.dart';
import 'package:blablabla/widgets/inputs/bla_button.dart';
import 'package:flutter/material.dart';

List<Ride> getTodaysRides() {
  DateTime today = DateTime.now();
  return fakeRides.where((ride) {
    return ride.departureDate.year == today.year &&
        ride.departureDate.month == today.month &&
        ride.departureDate.day == today.day;
  }).toList();
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: BlaButton(
            Text('Click Me'),
            onPressed: () {
              print('Button Pressed!');
            },
            icon: Icons.thumb_up,
            isPrimary: true,
          ),
        ),
      ),
    ),
  );
}

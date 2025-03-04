import 'package:test/test.dart';

import 'package:blablabla/dummy_data/dummy_data.dart';
import 'package:blablabla/model/ride_filter/ride_filter.dart';
import 'package:blablabla/model/ride_pref/ride_pref.dart';
import 'package:blablabla/repository/mock/mock_ride_repository.dart';
import 'package:blablabla/service/rides_service.dart';

void main() {
  RidesService.initialize(MockRideRepository());

  RidePreference pref = RidePreference(
    departure: cambodiaLocations[2],
    departureDate: DateTime.now(),
    arrival: cambodiaLocations[1],
    requestedSeats: 1,
  );


  RideFilter filter2 = RideFilter(acceptPets: true);

  test('Battambang -> Siemreap, today, 1 passenger', () {
    expect(RidesService.getRidesFor(pref).length, 4);
  });
  test('Battambang -> Siemreap, today, 1 passenger and accept pets', () {
    expect(RidesService.getRidesFor(pref, filter: filter2).length, 1);
  });
}

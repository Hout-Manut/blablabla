import 'package:blablabla/dummy_data/dummy_data.dart';
import 'package:blablabla/model/ride/ride.dart';
import 'package:blablabla/model/ride_filter/ride_filter.dart';
import 'package:blablabla/model/ride_pref/ride_pref.dart';
import 'package:blablabla/model/ride_sort/ride_sort.dart';
import 'package:blablabla/repository/ride_repository.dart';

class MockRideRepository extends RideRepository {
  final List<Ride> _rides = battambangRides;

  @override
  List<Ride> getRides(
    RidePreference preference,
    RideFilter? filter,
    RideSort? sort,
  ) {
    return _rides;
  }
}

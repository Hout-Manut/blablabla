import 'package:blablabla/model/ride/ride.dart';
import 'package:blablabla/model/ride_filter/ride_filter.dart';
import 'package:blablabla/model/ride_pref/ride_pref.dart';
import 'package:blablabla/model/ride_sort/ride_sort.dart';

abstract class RideRepository {
  List<Ride> getRides(RidePreference preference, RideFilter? filter, RideSort? sort);
}

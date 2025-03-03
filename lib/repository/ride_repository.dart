import 'package:blablabla/model/ride/ride.dart';
import 'package:blablabla/model/ride_filter/ride_filter.dart';
import 'package:blablabla/model/ride_pref/ride_pref.dart';

abstract class RideRepository {
  List<Ride> getRides(RidePreference preference, RideFilter? filter);
}

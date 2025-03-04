import 'package:blablabla/dummy_data/dummy_data.dart';
import 'package:blablabla/model/ride/ride.dart';
import 'package:blablabla/model/ride_filter/ride_filter.dart';
import 'package:blablabla/model/ride_pref/ride_pref.dart';
import 'package:blablabla/model/ride_sort/ride_sort.dart';
import 'package:blablabla/repository/ride_repository.dart';
import 'package:blablabla/service/ride_sort_service.dart';

class MockRideRepository extends RideRepository {
  final List<Ride> _rides = battambangRides;

  @override
  List<Ride> getRides(
    RidePreference preference,
    RideFilter? filter,
    RideSort? sort,
  ) {
    /// Mock only
    DateTime today = DateTime(
      preference.departureDate.year,
      preference.departureDate.month,
      preference.departureDate.day,
    );
    Iterable<Ride> foundRides = _rides.where((ride) {
      return ride.departureLocation == preference.departure &&
          ride.arrivalLocation == preference.arrival &&
          ride.departureDate.isAfter(today) &&
          ride.availableSeats >= preference.requestedSeats;
    });
    if (filter != null) {
      foundRides = foundRides.where((ride) {
        return ride.acceptPets == filter.acceptPets;
      });
    }
    List<Ride> foundRidesList = foundRides.toList();
    if (sort != null) {
      foundRidesList.sort(RideSortService.getSorter(sort));
      if (sort.reversed) foundRidesList = foundRidesList.reversed.toList();
    }

    return foundRidesList;
  }
}

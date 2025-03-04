import 'package:blablabla/model/ride/ride.dart';
import 'package:blablabla/model/ride_sort/ride_sort.dart';

class RideSortService {
  static int Function(Ride a, Ride b) getSorter(RideSort rideSort) {
    switch (rideSort.type) {
      case SortType.departureLocation:
        return sortByDepartureLocation;
      case SortType.departureDate:
        return sortByDepartureDate;
      case SortType.arrivalLocation:
        return sortByArrivalLocation;
      case SortType.arrivalDateTime:
        return sortByArrivalDateTime;
      case SortType.pricePerSeat:
        return sortByPricePerSeat;
      case SortType.availableSeats:
        return sortByAvailableSeats;
    }
  }

  static int sortByDepartureLocation(Ride a, Ride b) {
    return a.departureLocation.name.compareTo(b.departureLocation.name);
  }

  static int sortByDepartureDate(Ride a, Ride b) {
    return a.departureDate.compareTo(b.departureDate);
  }

  static int sortByArrivalLocation(Ride a, Ride b) {
    return a.arrivalLocation.name.compareTo(b.arrivalLocation.name);
  }

  static int sortByArrivalDateTime(Ride a, Ride b) {
    return a.arrivalDateTime.compareTo(b.arrivalDateTime);
  }

  static int sortByPricePerSeat(Ride a, Ride b) {
    return a.pricePerSeat.compareTo(b.pricePerSeat);
  }

  static int sortByAvailableSeats(Ride a, Ride b) {
    return a.availableSeats.compareTo(b.availableSeats);
  }

  // Generic method to sort based on a function parameter
  static void sort(
    List<Ride> rides,
    int Function(Ride a, Ride b) comparisonFunction,
  ) {
    rides.sort(comparisonFunction);
  }
}

enum SortType {
  departureLocation,
  departureDate,
  arrivalLocation,
  arrivalDateTime,
  driverVerified,
  pricePerSeat,
  availableSeats,
}

enum SortOrder { asc, desc }

class RideSort {
  final SortType type;
  final SortOrder order;

  RideSort({required this.type, required this.order});
}

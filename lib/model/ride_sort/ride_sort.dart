enum SortType {
  departureLocation,
  departureDate,
  arrivalLocation,
  arrivalDateTime,
  pricePerSeat,
  availableSeats,
}

// enum SortOrder { asc, desc }


class RideSort {
  final SortType type;
  final bool reversed;

  const RideSort({required this.type, this.reversed = false});
}

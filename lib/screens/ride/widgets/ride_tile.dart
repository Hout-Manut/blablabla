import 'package:blablabla/model/ride/ride.dart';
import 'package:blablabla/utils/date_time_util.dart';
import 'package:flutter/material.dart';

class RideTile extends StatelessWidget {
  final Ride ride;
  final void Function() onPressed;

  const RideTile({super.key, required this.ride, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: SizedBox(
          width: double.infinity,
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Departure: ${ride.departureLocation.name}'),
              Text('Arrival: ${ride.arrivalLocation.name}'),
              Text('Time: ${DateTimeUtils.formatDateTime(ride.departureDate)}'),
              Text('Seats: ${ride.availableSeats}'),
            ],
          ),
        ),
      ),
    );
  }
}

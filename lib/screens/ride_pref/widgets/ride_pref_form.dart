import 'package:blablabla/widgets/inputs/bla_number_spinner.dart';
import 'package:flutter/material.dart';

import 'package:blablabla/theme/theme.dart';
import 'package:blablabla/utils/animations_util.dart';
import 'package:blablabla/utils/date_time_util.dart';
import 'package:blablabla/widgets/display/bla_divider.dart';
import 'package:blablabla/widgets/inputs/bla_location_picker.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A departure location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;
  final void Function(RidePref) onSearchPressed;

  const RidePrefForm({
    super.key,
    this.initRidePref,
    required this.onSearchPressed,
  });

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  late DateTime nowDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------
  @override
  void initState() {
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      departureDate = widget.initRidePref!.departureDate;
      arrival = widget.initRidePref!.arrival;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null;
      departureDate = DateTime.now();
      arrival = null;
      requestedSeats = 1;
    }
    nowDate = DateTime.now();
    super.initState();
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  bool get swapVisible => departure != null || arrival != null;

  void swapLocations() {
    setState(() {
      Location? buffer = departure;
      departure = arrival;
      arrival = buffer;
    });
  }

  void departurePressed() async {
    Location? newLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(
        BlaLocationPicker(initLocation: departure),
      ),
    );

    if (newLocation != null) {
      setState(() {
        departure = newLocation;
      });
    }
  }

  void arrivalPressed() async {
    Location? newLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(
        BlaLocationPicker(initLocation: arrival),
      ),
    );

    if (newLocation != null) {
      setState(() {
        arrival = newLocation;
      });
    }
  }

  void datePressed() {}

  void seatsPressed() async {
    int? seatNum = await Navigator.of(context).push(
      AnimationUtils.createBottomToTopRoute(
        BlaNumberSpinner(initNumber: requestedSeats),
      ),
    );

    if (seatNum != null) {
      setState(() {
        requestedSeats = seatNum;
      });
    }
  }

  void searchPressed() {
    if (departure == null) {
      return;
    }
    if (arrival == null) {
      return;
    }
    if (departureDate.isBefore(nowDate)) {
      return;
    }
    if (requestedSeats < 1) {
      return;
    }

    RidePref newRidePref = RidePref(
      departure: departure!,
      departureDate: departureDate,
      arrival: arrival!,
      requestedSeats: requestedSeats,
    );

    widget.onSearchPressed(newRidePref);
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  Widget buildInput(
    BuildContext context, {
    required Icon icon,
    required String text,
    required Color textColor,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: BlaSpacings.m,
          vertical: BlaSpacings.m,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDepartureInput(BuildContext context) {
    String departureStr;
    Color textColor;

    if (departure == null) {
      departureStr = 'Leaving from';
      textColor = BlaColors.neutralLight;
    } else {
      departureStr = departure!.name;
      textColor = Colors.black;
    }
    return InkWell(
      onTap: departurePressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: BlaSpacings.m,
          vertical: BlaSpacings.m,
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.radio_button_off_rounded,
                    color: BlaColors.neutralLight,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    departureStr,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (swapVisible)
              InkWell(
                onTap: swapLocations,
                child: Icon(Icons.swap_vert_sharp, color: BlaColors.primary),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildArrivalInput(BuildContext context) {
    String arrivalStr;
    Color textColor;

    if (arrival == null) {
      arrivalStr = 'Going to';
      textColor = BlaColors.neutralLight;
    } else {
      arrivalStr = arrival!.name;
      textColor = Colors.black;
    }

    return buildInput(
      context,
      icon: Icon(Icons.radio_button_off_rounded, color: BlaColors.neutralLight),
      text: arrivalStr,
      textColor: textColor,
      onTap: arrivalPressed,
    );
  }

  Widget buildDateInput(BuildContext context) {
    String dateStr = DateTimeUtils.formatDateTime(departureDate);
    return buildInput(
      context,
      icon: Icon(Icons.calendar_month_rounded, color: BlaColors.neutralLight),
      text: dateStr,
      textColor: Colors.black,
      onTap: datePressed,
    );
  }

  Widget buildSeatsInput(BuildContext context) {
    String seatsStr = requestedSeats.toString();

    return buildInput(
      context,
      icon: Icon(Icons.person_outline, color: BlaColors.neutralLight),
      text: seatsStr,
      textColor: Colors.black,
      onTap: seatsPressed,
    );
  }

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildDepartureInput(context),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: BlaSpacings.l),
          child: BlaDivider(),
        ),
        buildArrivalInput(context),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: BlaSpacings.l),
          child: BlaDivider(),
        ),
        buildDateInput(context),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: BlaSpacings.l),
          child: BlaDivider(),
        ),
        buildSeatsInput(context),
        InkWell(
          onTap: searchPressed,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: BlaSpacings.m),
            color: BlaColors.primary,
            child: Center(
              child: Text("Search", style: TextStyle(color: BlaColors.white)),
            ),
          ),
        ),
      ],
    );
  }
}

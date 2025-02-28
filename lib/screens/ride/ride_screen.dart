import 'package:flutter/material.dart';

import 'package:blablabla/model/ride/ride.dart';
import 'package:blablabla/screens/ride/widgets/ride_tile.dart';
import 'package:blablabla/service/rides_service.dart';
import 'package:blablabla/theme/theme.dart';
import 'package:blablabla/utils/date_time_util.dart';
import 'package:blablabla/widgets/actions/bla_button.dart';

import 'package:blablabla/model/ride_pref/ride_pref.dart';

class RideScreen extends StatefulWidget {
  final RidePref initRidePref;
  const RideScreen({super.key, required this.initRidePref});

  @override
  State<StatefulWidget> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  late RidePref ridePref;
  List<Ride> matchingRides = [];

  String get prefTitle =>
      "${ridePref.departure.name} → ${ridePref.arrival.name}";

  String get prefSubTitle =>
      "${DateTimeUtils.formatDateTime(ridePref.departureDate)}, ${ridePref.requestedSeats} passenger${ridePref.requestedSeats > 1 ? "s" : ""}";

  @override
  void initState() {
    ridePref = widget.initRidePref;
    getMatchingRides();
    super.initState();
  }

  void getMatchingRides() {
    matchingRides = RidesService.getRidesFor(ridePref);
    print(matchingRides);
  }

  void onFilterPressed() {}

  void onRidePrefPressed() {}

  void onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(BlaSpacings.m),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: BlaSpacings.m,
                vertical: BlaSpacings.s,
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(),
                borderRadius: BorderRadius.circular(BlaSpacings.radius),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onBackPressed,
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: BlaColors.iconNormal,
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: onRidePrefPressed,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            prefTitle,
                            style: BlaTextStyles.label.copyWith(
                              color: BlaColors.textNormal,
                            ),
                          ),
                          Text(
                            prefSubTitle,
                            style: BlaTextStyles.label.copyWith(
                              color: BlaColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: BlaButton(
                      Text("Filter"),
                      onPressed: onFilterPressed,
                      isPrimary: false,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder:
                    (ctx, index) =>
                        RideTile(ride: matchingRides[index], onPressed: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

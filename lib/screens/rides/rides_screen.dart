import 'package:blablabla/model/ride_filter/ride_filter.dart';
import 'package:blablabla/model/ride_sort/ride_sort.dart';
import 'package:blablabla/screens/rides/widgets/ride_filter_model.dart';
import 'package:blablabla/screens/rides/widgets/ride_pref_modal.dart';
import 'package:blablabla/service/ride_prefs_service.dart';
import 'package:blablabla/utils/animations_util.dart';
import 'package:flutter/material.dart';
import 'package:blablabla/screens/rides/widgets/ride_pref_bar.dart';

import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';

import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///
class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  RidePreference get currentPreference =>
      RidePrefService.instance.currentPreference!; // 1
  RideFilter? currentFilter;
  RideSort? currentSort;

  List<Ride> get matchingRides => RidesService.getRidesFor(
    currentPreference,
    filter: currentFilter,
    sort: currentSort,
  );

  void onBackPressed() {
    Navigator.of(context).pop(); //  Back to the previous view
  }

  void onPreferencePressed() async {
    // 6
    RidePreference? newPreference = await Navigator.of(context).push<RidePreference>(
      AnimationUtils.createBottomToTopRoute(
        RidePrefModal(initialPreference: currentPreference),
      ),
    );

    if (newPreference != null) {
      setState(() {
        // 10
        RidePrefService.instance.setCurrentPreference(newPreference);
      });
    }
  }

  void onFilterPressed() async {
    (RideFilter?, RideSort?)? newFilterAndSort = await Navigator.of(context).push<(RideFilter?, RideSort?)>(
      AnimationUtils.createBottomToTopRoute(
        RideFilterModel(initialFilter: currentFilter, initialSort: currentSort,),
      ),
    );

    if (newFilterAndSort != null) {
      setState(() {
        currentFilter = newFilterAndSort.$1;
        currentSort = newFilterAndSort.$2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            // Top search Search bar
            RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: onBackPressed,
              onPreferencePressed: onPreferencePressed,
              onFilterPressed: onFilterPressed,
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

import 'package:blablabla/model/ride_filter/ride_filter.dart';
import 'package:blablabla/model/ride_sort/ride_sort.dart';
import 'package:blablabla/theme/theme.dart';
import 'package:blablabla/widgets/actions/bla_button.dart';
import 'package:blablabla/widgets/actions/bla_icon_button.dart';
import 'package:blablabla/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';

enum RideSortPreset {
  earliestDeparture(
    'Earliest departure',
    RideSort(type: SortType.departureDate),
    Icons.access_time_rounded,
  ),
  lowestPrice(
    'Lowest price',
    RideSort(type: SortType.pricePerSeat),
    Icons.attach_money_rounded,
  );

  final String name;
  final RideSort sort;
  final IconData iconData;

  const RideSortPreset(this.name, this.sort, this.iconData);
}

class RideFilterModel extends StatefulWidget {
  final RideFilter? initialFilter;
  final RideSort? initialSort;

  const RideFilterModel({
    super.key,
    required this.initialFilter,
    required this.initialSort,
  });

  @override
  State<RideFilterModel> createState() => _RideFilterModelState();
}

class _RideFilterModelState extends State<RideFilterModel> {
  void onBackSelected() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // RideSortPreset.values.indexOf(element)
    if (widget.initialFilter != null) {
      if (widget.initialFilter!.acceptPets != null) {
        acceptPets = widget.initialFilter!.acceptPets!;
      }
    }

    // Sortings are not fully implemented yet and there are only 2 options for now.
    // So I treat everything as the first option except the pricePerSeat option.
    if (widget.initialSort != null) {
      switch (widget.initialSort!.type) {
        case SortType.pricePerSeat:
          selectedSort = 1;
        default:
          selectedSort = 0;
      }
    } else {
      selectedSort = 0;
    }

    super.initState();
  }

  bool acceptPets = false;
  late int selectedSort;

  void onSortPressed(int? index) {
    if (index != null) {
      setState(() {
        selectedSort = index;
      });
    }
  }

  void onConfirmPressed() {
    RideSortPreset selectedSortPreset = RideSortPreset.values[selectedSort];
    RideSort newSort = selectedSortPreset.sort;

    RideFilter? newFilter;

    // If acceptPets is unchecked, dont use it as a filter
    if (acceptPets) {
      newFilter = RideFilter(acceptPets: true);
    }

    Navigator.of(context).pop((newFilter, newSort));
  }

  void onAcceptPetsPressed(bool? value) {
    if (value != null) {
      setState(() {
        acceptPets = value;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back icon
            BlaIconButton(onPressed: onBackSelected, icon: Icons.close),
            SizedBox(height: BlaSpacings.m),

            // Title
            Text(
              "Filter",
              style: BlaTextStyles.title.copyWith(color: BlaColors.textNormal),
            ),
            SizedBox(height: BlaSpacings.m),

            Text(
              "Sort by",
              style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
            ),
            SizedBox(height: BlaSpacings.s),
            ...List.generate(RideSortPreset.values.length, (index) {
              RideSortPreset sort = RideSortPreset.values[index];
              return ListTile(
                title: Text(sort.name, style: BlaTextStyles.button),
                leading: Radio(
                  value: index,
                  groupValue: selectedSort,
                  onChanged: (value) {onSortPressed(index);},
                  hoverColor: Colors.transparent,
                ),
                trailing: Icon(sort.iconData, color: BlaColors.neutral),
                onTap: () {onSortPressed(index);},
              );
            }),
            const BlaDivider(),
            SizedBox(height: BlaSpacings.s),

            Text(
              "Details",
              style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
            ),
            SizedBox(height: BlaSpacings.s),
            ListTile(
              title: Text('Pets accepted', style: BlaTextStyles.button),
              leading: Checkbox(
                value: acceptPets,
                onChanged: onAcceptPetsPressed,
              ),
              onTap: () {onAcceptPetsPressed(!acceptPets);},
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 100,
        child: BlaButton(text: 'See rides', onPressed: onConfirmPressed),
      ),
    );
  }
}

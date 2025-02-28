import 'package:flutter/material.dart';

import 'package:blablabla/theme/theme.dart';
import 'package:blablabla/widgets/actions/bla_button.dart';

class BlaNumberSpinner extends StatefulWidget {
  final int initNumber;

  const BlaNumberSpinner({super.key, this.initNumber = 1});

  @override
  State<StatefulWidget> createState() => _BlaNumberSpinnerState();
}

class _BlaNumberSpinnerState extends State<BlaNumberSpinner> {
  static const int maxNum = 8;
  late int seatNum;

  bool get isMax => seatNum == maxNum;
  bool get isMin => seatNum == 1;

  @override
  void initState() {
    seatNum = widget.initNumber;
    super.initState();
  }

  void onConfirm() {
    Navigator.of(context).pop(seatNum);
  }

  void onBackPressed() {
    Navigator.of(context).pop();
  }

  void increaseNum() {
    if (isMax) return;

    setState(() {
      seatNum += 1;
    });
  }

  void decreaseNum() {
    if (isMin) return;

    setState(() {
      seatNum -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(BlaSpacings.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: onBackPressed,
              icon: Icon(Icons.close_rounded, color: BlaColors.primary),
            ),
            SizedBox(height: BlaSpacings.m),
            Text("Number of seats to book", style: BlaTextStyles.heading),
            Expanded(
              child: Row(
                children: [
                  IconButton(
                    onPressed: decreaseNum,
                    icon: Icon(
                      Icons.remove_rounded,
                      color: isMin ? BlaColors.disabled : BlaColors.primary,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        seatNum.toString(),
                        style: BlaTextStyles.heading,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: increaseNum,
                    icon: Icon(
                      Icons.add_rounded,
                      color: isMax ? BlaColors.disabled : BlaColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: BlaSpacings.xl),
              child: SizedBox(
                height: 32,
                child: Center(
                  child: BlaButton(Text('Confirm'), onPressed: onConfirm),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

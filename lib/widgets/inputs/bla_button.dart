import 'package:blablabla/theme/theme.dart';
import 'package:flutter/material.dart';

class BlaButton extends StatelessWidget {
  final IconData? icon;
  final Text text;
  final bool isPrimary;
  final void Function() onPressed;

  const BlaButton(
    this.text, {
    super.key,
    required this.onPressed,
    this.icon,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        isPrimary ? BlaColors.primary : BlaColors.white;
    final Color textColor = isPrimary ? BlaColors.white : BlaColors.primary;
    final Color borderColor =
        isPrimary ? Colors.transparent : BlaColors.greyLight;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(
          horizontal: BlaSpacings.m,
          vertical: BlaSpacings.s,
        ),
        side: BorderSide(
          color: borderColor,
          width: 1.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BlaSpacings.radius),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon!,
              color: textColor,
            ),
          if (icon != null) const SizedBox(width: BlaSpacings.s),
          Text(
            text.data!,
            style: BlaTextStyles.button.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}

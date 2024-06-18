import 'package:flutter/material.dart';
import 'package:mawqifi/common/color-extension.dart';

class BookingProgressButton extends StatelessWidget {
  const BookingProgressButton(
      {super.key, required this.onPressed, required this.statusId});

  final int statusId;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.maxFinite,
      elevation: 0,
      color: (statusId == 0)
          ? Colors.orange.shade100
          : (statusId == 1)
              ? Colors.grey.shade100
              : Colors.red.shade100,
      height: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        (statusId == 0)
            ? "In Progress"
            : (statusId == 1)
                ? "Completed"
                : "Canceled",
        style: TextStyle(
          color: (statusId == 0)
              ? Colors.orange
              : (statusId == 1)
                  ? TColor.secondaryText
                  : Colors.red,
          fontSize: 16,
        ),
      ),
    );
  }
}

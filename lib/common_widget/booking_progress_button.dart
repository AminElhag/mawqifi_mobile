import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mawqifi/common/color-extension.dart';

class BookingProgressButton extends StatelessWidget {
  const BookingProgressButton(
      {super.key, required this.onPressed, required this.statusId});

  final int statusId;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(statusId);
    }
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.maxFinite,
      elevation: 0,
      color: (statusId == BookingProgress.wanting.index)
          ? Colors.orange.shade100
          : (statusId == BookingProgress.inProgress.index)
          ? Colors.green.shade100
          : (statusId == BookingProgress.completed.index)
          ? Colors.blue.shade100
          : Colors.red.shade100,
      height: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        (statusId == BookingProgress.wanting.index)
            ? "Wanting"
            : (statusId == BookingProgress.inProgress.index)
                ? "In Progress"
                : (statusId == BookingProgress.completed.index)
                    ? "Completed"
                    : "Canceled",
        style: TextStyle(
          color: (statusId == BookingProgress.wanting.index)
              ? Colors.orange
              : (statusId == BookingProgress.inProgress.index)
              ? Colors.green
              : (statusId == BookingProgress.completed.index)
              ? Colors.blue
              : Colors.red,
          fontSize: 16,
        ),
      ),
    );
  }
}

enum BookingProgress { wanting, inProgress, completed, canceled }

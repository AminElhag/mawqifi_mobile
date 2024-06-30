import 'package:flutter/material.dart';

class SnackBarWidget {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> get(
    BuildContext context,
    Color? backgroundColor,
    String message,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(16),
          height: 60,
          decoration: BoxDecoration(
            color: (backgroundColor == null)
                ? const Color(0xFFC72C41)
                : backgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                message,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common_model/booking_a_spot_model.dart';
import 'package:mawqifi/features/booking/presentation/page/booking_details_page.dart';
import 'package:mawqifi/features/booking/presentation/page/booking_page.dart';

class BookingResultPage extends StatefulWidget {
  const BookingResultPage({
    super.key,
    required this.bookingASpotModel,
  });

  final BookingASpotModel bookingASpotModel;

  static route(BookingASpotModel bookingASpotModel) => MaterialPageRoute(
      builder: (context) => BookingResultPage(
            bookingASpotModel: bookingASpotModel,
          ));

  @override
  State<BookingResultPage> createState() => _BookingResultPageState();
}

class _BookingResultPageState extends State<BookingResultPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 1),
      () {
        Navigator.pushReplacement(context, BookingDetailsPage.route(widget.bookingASpotModel.bookingId));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_sharp,
            size: 120,
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "Booking Successful !!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "Yah, parking slot is booked for you",
            style: TextStyle(color: TColor.secondaryText),
          )
        ],
      ),
    ));
  }
}

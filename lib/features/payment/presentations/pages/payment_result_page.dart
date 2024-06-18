import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/features/main/presentations/page/main_page.dart';

class PaymentResultPage extends StatefulWidget {
  const PaymentResultPage({super.key});

  static route() =>
      MaterialPageRoute(builder: (context) => const PaymentResultPage());

  @override
  State<PaymentResultPage> createState() => _PaymentResultPageState();
}

class _PaymentResultPageState extends State<PaymentResultPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.push(context, MainPage.route());
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
            "Payment Successful !!",
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

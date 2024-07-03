import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/features/auth/mobile_login/presentations/page/mobile_number_page.dart';

class SplashScreenThree extends StatelessWidget {
  const SplashScreenThree({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const SplashScreenThree(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 160,),
          const Spacer(),
          Image.asset("assets/img/optimiza-inventario.png"),
          const Text(
            "Start Parking Smarter",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  "Say goodbye to the frustration of searching for parking spots. Now you can start parking smarter today. Experience now the stress-free parking wherever you go.",
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.push(context, MobileNumberPage.route());
                  },
                  elevation: 0,
                  color: TColor.primary,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Get Started →",
                    style: TextStyle(
                      color: TColor.primaryTextW,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

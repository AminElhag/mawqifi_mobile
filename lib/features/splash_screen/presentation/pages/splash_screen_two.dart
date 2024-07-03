import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/features/auth/mobile_login/presentations/page/mobile_number_page.dart';
import 'package:mawqifi/features/splash_screen/presentation/pages/splash_screen_three.dart';
class SplashScreenTwo extends StatelessWidget {
  const SplashScreenTwo({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const SplashScreenTwo(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap:() {
                    Navigator.push(context, MobileNumberPage.route());
                  },
                  child: const Text("Skip"),
                )
              ],
            ),
          ),
          const Spacer(),
          Image.asset("assets/img/parking_amico.png"),
          const Text(
            "Book with Ease",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  "Booking your parking spot is now easier thna ever. Simply browse through available spots, select the one that suits you best, and complete your booking.",
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
                    Navigator.push(context, SplashScreenThree.route());
                  },
                  elevation: 0,
                  color: TColor.primary,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "next",
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

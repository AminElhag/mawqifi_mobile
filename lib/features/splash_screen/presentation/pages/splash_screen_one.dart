import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/features/auth/mobile_login/presentations/page/mobile_number_page.dart';
import 'package:mawqifi/features/splash_screen/presentation/pages/splash_screen_two.dart';

class SplashScreenOne extends StatelessWidget {
  const SplashScreenOne({super.key});

  static route() => MaterialPageRoute(builder: (context) => const SplashScreenOne(),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(16),
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
          Spacer(),
          Image.asset("assets/img/girl_in_parking.png"),
          const Text(
            "Find Your Perfect Spot",
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
                  "Wherever you're we allow you to find the perfect parking spot tailored to your vehicle's needs.",
                ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.push(context, SplashScreenTwo.route());
                  },
                  elevation: 0,
                  color: TColor.primary,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Next",
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

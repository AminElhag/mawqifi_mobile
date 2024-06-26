import 'package:flutter/material.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common_widget/profile_action_item.dart';
import 'package:mawqifi/features/proflie/presentations/pages/create_profile_page.dart';
import 'package:mawqifi/features/splash_screen/presentation/pages/splash_screen_one.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 22.0),
              child: CircleAvatar(
                radius: 30,
                backgroundImage:
                    AssetImage("assets/img/profile_test_img.png"),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              "John Smith",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            )
          ],
        ),
        const SizedBox(
          height: 26,
        ),
        ProfileActionItem(
          title: "Account Info",
          icon: Icons.account_circle,
          onTap: () {
            Navigator.push(context, CreateProfilePage.route(Globs.udValueString(PreferenceKey.phoneNumber),true));
          },
        ),
        const SizedBox(
          height: 26,
        ),
        ProfileActionItem(
          title: "My Vehicles",
          icon: Icons.drive_eta,
          onTap: () {},
        ),
        const SizedBox(
          height: 26,
        ),
        ProfileActionItem(
          title: "Payments",
          icon: Icons.payments,
          onTap: () {},
        ),
        const SizedBox(
          height: 26,
        ),
        ProfileActionItem(
          title: "Refer & Earn",
          icon: Icons.card_giftcard,
          onTap: () {},
        ),
        const SizedBox(
          height: 26,
        ),
        ProfileActionItem(
          title: "Help",
          icon: Icons.help,
          onTap: () {},
        ),
        const SizedBox(
          height: 26,
        ),
        ProfileActionItem(
          title: "Logout",
          icon: Icons.logout,
          onTap: () {
            Globs.udClearAllKey()?.then(
              (value) {
                if (value) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    SplashScreenOne.route(),
                    (route) => false,
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}

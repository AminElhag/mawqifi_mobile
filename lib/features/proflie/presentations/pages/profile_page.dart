import 'package:flutter/material.dart';
import 'package:mawqifi/common/color-extension.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Icon(
                    Icons.account_circle,
                    color: TColor.secondary,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Account Info",
                  style: TextStyle(fontSize: 18, color: TColor.secondaryText),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Icon(
                    Icons.drive_eta,
                    color: TColor.secondary,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "My Vehicles",
                  style: TextStyle(fontSize: 18, color: TColor.secondaryText),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Icon(
                    Icons.payments,
                    color: TColor.secondary,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Payments",
                  style: TextStyle(fontSize: 18, color: TColor.secondaryText),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Icon(
                    Icons.card_giftcard,
                    color: TColor.secondary,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Refer & Earn",
                  style: TextStyle(fontSize: 18, color: TColor.secondaryText),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Icon(
                    Icons.help,
                    color: TColor.secondary,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Help",
                  style: TextStyle(fontSize: 18, color: TColor.secondaryText),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Icon(
                    Icons.logout,
                    color: TColor.secondary,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Logout",
                  style: TextStyle(fontSize: 18, color: TColor.secondaryText),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

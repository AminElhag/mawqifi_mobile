import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/features/booking/presentation/page/booking_list_page.dart';
import 'package:mawqifi/features/parking/presentations/pages/parking_page.dart';
import 'package:mawqifi/features/proflie/presentations/pages/profile_page.dart';
import 'package:mawqifi/features/search/presentations/pages/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const MainPage(),
      );

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;
  bool hasNewNotifications = Random().nextBool();

  final pages = [
    const ParkingPage(),
    /*const SearchPage(),*/
    const BookingListPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ((pageIndex == 0) ? AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage("assets/img/profile_test_img.png"),
          ),
        ),
        leadingWidth: 64,
        title: Text(
          "Welcome 👋 ${Globs.udValueString(PreferenceKey.fullName)}",
          style: TextStyle(fontSize: 16, color: TColor.secondaryText),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                const Icon(Icons.notifications_none_sharp),
                 Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: (hasNewNotifications) ? 12 : 0,
                ),
              ],
            ),
          )
        ],
      ) : (pageIndex == 1) ? AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Bookings", style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ) : (pageIndex == 3) ? null : AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Profile", style: TextStyle(fontWeight: FontWeight.w600),
        ),

      )),
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                  icon: pageIndex == 0
                      ? const Icon(
                          Icons.home_filled,
                          size: 35,
                        )
                      : Icon(
                          Icons.home_outlined,
                          size: 35,
                          color: TColor.secondary,
                        ),
                ),
                const Text(
                  "Home",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            /*Column(
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 1;
                    });
                  },
                  icon: pageIndex == 1
                      ? const Icon(
                          Icons.search,
                          size: 35,
                        )
                      : Icon(
                          Icons.search,
                          size: 35,
                          color: TColor.secondary,
                        ),
                ),
                const Text(
                  "Search",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),*/
            Column(
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 1;
                    });
                  },
                  icon: pageIndex == 1
                      ? const Icon(
                          Icons.bookmarks,
                          size: 35,
                        )
                      : Icon(
                          Icons.bookmarks_outlined,
                          size: 35,
                          color: TColor.secondary,
                        ),
                ),
                const Text(
                  "Booking",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 2;
                    });
                  },
                  icon: pageIndex == 2
                      ? const Icon(
                          Icons.person,
                          size: 35,
                        )
                      : Icon(
                          Icons.person_outline,
                          size: 35,
                          color: TColor.secondary,
                        ),
                ),
                const Text(
                  "Profile",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

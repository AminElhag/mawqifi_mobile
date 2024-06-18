import 'package:flutter/material.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common_widget/booking_item.dart';
import 'package:mawqifi/common_widget/park_item.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const BookingPage(),
      );

  @override
  Widget build(BuildContext context) {
    final List nearParkingList = [
      {
        "image_uri": "assets/img/R.png",
        "title": "Garage Parking",
        "distance": "2.3km",
        "details":
        "25 A, Block-C,New town, Near New remix mail, Pune, Maharashtra.",
        "price": "\$ 20/hour",
      },
      {
        "image_uri": "assets/img/parking_test_image.png",
        "title": "Garage Parking",
        "distance": "2.3km",
        "details":
        "25 A, Block-C,New town, Near New remix mail, Pune, Maharashtra.",
        "price": "\$ 20/hour",
        "status_id" : 0,
      },
      {
        "image_uri": "assets/img/parking_test_image.png",
        "title": "Garage Parking",
        "distance": "2.3km",
        "details":
        "25 A, Block-C,New town, Near New remix mail, Pune, Maharashtra.",
        "price": "\$ 20/hour",
        "status_id" : 2,
      },
      {
        "image_uri": "assets/img/parking_test_image.png",
        "title": "Garage Parking",
        "distance": "2.3km",
        "details":
        "25 A, Block-C,New town, Near New remix mail, Pune, Maharashtra.",
        "price": "\$ 20/hour",
        "status_id" : 1,
      },
      {
        "image_uri": "assets/img/parking_test_image.png",
        "title": "Garage Parking",
        "distance": "2.3km",
        "details":
        "25 A, Block-C,New town, Near New remix mail, Pune, Maharashtra.",
        "price": "\$ 20/hour",
        "status_id" : 1,
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: context.height - 195,
            child: ListView.builder(
              itemCount: nearParkingList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var item = nearParkingList[index] as Map;
                return BookingItem(
                  imageUrl: item['image_uri'],
                  name: item['title'],
                  distance: item['distance'],
                  details: item['details'],
                  price: item['price'],
                  startTime: "9:30 AM",
                  endTime: "11:30 PM",
                  statusId: item['status_id'] as int? ?? 2,
                  onPressed: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

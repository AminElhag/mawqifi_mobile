import 'package:flutter/material.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common_widget/park_item.dart';
import 'package:mawqifi/features/parking_details/presentations/page/parking_details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const HomePage(),
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
      },
      {
        "image_uri": "assets/img/parking_test_image.png",
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
      },
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
      },
      {
        "image_uri": "assets/img/parking_test_image.png",
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
      },
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
      },
      {
        "image_uri": "assets/img/parking_test_image.png",
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
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Find the best place to park !!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 6,
          ),
          TextField(
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: TColor.secondary,
              ),
              hintText: "Search",
              hintStyle: TextStyle(color: TColor.secondary),
              helperStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          const Text(
            "Parking Nearby",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
            height: context.height - 350,
            child: ListView.builder(
              itemCount: nearParkingList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var item = nearParkingList[index] as Map;
                return ParkItem(
                  imageUrl: item['image_uri'],
                  name: item['title'],
                  distance: item['distance'],
                  details: item['details'],
                  price: item['price'],
                  onPressed: () {
                    Navigator.push(context, ParkingDetailsPage.route());
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

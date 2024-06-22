import 'package:flutter/material.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common_widget/round_button.dart';
import 'package:mawqifi/features/parking_details/presentations/page/enter_booking_details_page.dart';
import 'package:readmore/readmore.dart';

class ParkingDetailsPage extends StatefulWidget {
  const ParkingDetailsPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const ParkingDetailsPage(),
      );

  @override
  State<ParkingDetailsPage> createState() => _ParkingDetailsPageState();
}

class _ParkingDetailsPageState extends State<ParkingDetailsPage> {
  final myProducts = List<String>.generate(1000, (i) => 'Product $i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset("assets/img/R.png"),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Parking Lot of Capital University",
                        style:
                            TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Row(
                        children: [
                          Text(
                            "4.5",
                            style: TextStyle(color: TColor.secondaryText),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade700,
                            size: 16,
                          )
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "1541 Robin St, Auburndale",
                    style: TextStyle(color: TColor.secondaryText),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        onPressed: () {},
                        minWidth: double.minPositive,
                        elevation: 0,
                        color: TColor.lightGray,
                        height: 40,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.fit_screen),
                            const SizedBox(
                              width: 6,
                            ),
                            Text("10 km²"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      MaterialButton(
                        onPressed: () {},
                        minWidth: double.minPositive,
                        elevation: 0,
                        color: TColor.lightGray,
                        height: 40,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.alarm),
                            const SizedBox(
                              width: 6,
                            ),
                            Text("8 AM - 9 PM"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "RULES",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: TColor.secondaryText),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  ReadMoreText(
                    "These regulatons 'or the use Of Dotnmry Unovers.tv Paronq Area. In these Rules, unless the conte.t Otherwise these rules and tot the use of Dummy University Park'n.g Area. In these  Rules. the context otherwiseThese regulatons 'or the use Of Dotnmry Unovers.tv Paronq Area. In these Rules, unless the conte.t Otherwise these rules and tot the use of Dummy University Park'n.g Area. In these  Rules. the context otherwise",
                    trimMode: TrimMode.Line,
                    trimLines: 5,
                    trimLength: 240,
                    style: TextStyle(color: TColor.secondaryText),
                    colorClickableText: Colors.black,
                    trimCollapsedText: ' more...',
                    trimExpandedText: ' less',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "ADDRESS",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: TColor.secondaryText),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  ReadMoreText(
                    "Jl. Asaa No. Lot. 19 3. Gejora, By,aoe. Kota Putlif",
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    trimLength: 240,
                    style: TextStyle(color: TColor.secondaryText),
                    colorClickableText: Colors.black,
                    trimCollapsedText: ' more...',
                    trimExpandedText: ' less',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Direction",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Card(
                            // In many cases, the key isn't mandatory
                            key: ValueKey(myProducts[index]),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                width: 60,
                                child: Column(
                                  children: [
                                    Text("${index + 1} Hour"),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    const Text("10\$"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: RoundButton(
          titleColor: TColor.primaryTextW,
          backgroundColor: TColor.primary,
          title: "Book Parking",
          onPressed: () {
            Navigator.push(context, EnterBookingDetailsPage.route());
          },
        ),
      ),
    );
  }
}

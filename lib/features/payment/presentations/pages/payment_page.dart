import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common_widget/booking_progress_button.dart';
import 'package:mawqifi/common_widget/round_button.dart';
import 'package:mawqifi/features/payment/presentations/pages/payment_result_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const PaymentPage(),
      );

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List _listOfPaymentCard = [
    RadioPaymentItem(bankName: "Amin", accountNumber: "**** **** **** 1234", iconUri: "assets/img/mastercard.svg", index: 0),
    RadioPaymentItem(bankName: "Riyadh", accountNumber: "**** **** **** 5678", iconUri: "assets/img/mastercard.svg", index: 1),
    RadioPaymentItem(bankName: "Lonksenbark", accountNumber: "**** **** **** 5678", iconUri: "assets/img/mastercard.svg", index: 2)
  ];

  int groupValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded)),
        title: const Text(
          "Payment",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  "assets/img/R.png",
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: context.width - 150,
                                    child: const Text(
                                      "Garage Parking",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12),
                                    ),
                                  ),
                                  SizedBox(
                                    width: context.width - 150,
                                    child: Text(
                                      "25 A, Block-C,New town, Near New remix mail, Pune, Maharashtra.",
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: TColor.secondaryText,
                                          fontSize: 12),
                                    ),
                                  ),
                                  Text(
                                    "6 Jun 2024",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: TColor.secondaryText,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "10:30PM",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 12),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text("● - - - - - - - - - - - - - - ●"),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                "9:30AM",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 12),
                              ),
                            ],
                          ),
                          Text(
                            "2 hours",
                            maxLines: 2,
                            style: TextStyle(
                                color: TColor.secondaryText, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text(
                    "Credi & Debit Cards",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: _listOfPaymentCard
                                .map(
                                  (data) => InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      setState(() {
                                        groupValue = data.index;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Row(
                                          children: <Widget>[
                                            Radio(
                                              groupValue: groupValue,
                                              value: data.index,
                                              onChanged: (index) {
                                                setState(() {
                                                  groupValue = index ?? 0;
                                                });
                                              },
                                            ),
                                            Expanded(child: Row(
                                              children: [
                                                SizedBox(width: 12,),
                                                Text(data.accountNumber),
                                                SizedBox(width: 6,),
                                                SizedBox(width:60,child: Text(data.bankName,overflow: TextOverflow.clip,)),
                                                SizedBox(width: 6,),
                                                SvgPicture.asset(data.iconUri,height: 40,width: 40,)
                                              ],
                                            ),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 6,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 90),
                            child: Card(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {

                                },
                                child: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add),
                                    SizedBox(width: 6,),
                                    Text("Add New Card")
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 90,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("\$ 20",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  Text("View detailed bill"),
                ],
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(context, PaymentResultPage.route());
                },
                minWidth: 100,
                elevation: 0,
                color: TColor.primary,
                height: 50,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  "Proceed to Pay",
                  style: TextStyle(
                    color: TColor.primaryTextW,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RadioPaymentItem {
  String bankName,accountNumber,iconUri;
  int index;

  RadioPaymentItem({required this.bankName,required this.accountNumber,required this.iconUri, required this.index});
}

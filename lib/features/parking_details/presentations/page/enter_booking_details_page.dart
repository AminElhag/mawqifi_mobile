import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common_widget/round_button.dart';
import 'package:mawqifi/common_widget/text_field_widget.dart';
import 'package:mawqifi/features/payment/presentations/pages/payment_page.dart';

class EnterBookingDetailsPage extends StatefulWidget {
  const EnterBookingDetailsPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const EnterBookingDetailsPage(),
      );

  @override
  State<EnterBookingDetailsPage> createState() =>
      _EnterBookingDetailsPageState();
}

class _EnterBookingDetailsPageState extends State<EnterBookingDetailsPage> {
  int selectedDataIndex = 0;
  int selectedTimeIndex = 0;
  bool isAlarm = false;
  final List _selectDateChipsList = [
    "Today",
    "Tomorrow",
  ];
  final List _dNChipsList = [
    "AM",
    "PM",
  ];

  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

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
          "Enter Details",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      const TextFieldWidget(
                        textInputType: TextInputType.name,
                        hintText: "Mahindra Thar",
                        labelText: "Vehicle Type",
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const TextFieldWidget(
                        textInputType: TextInputType.name,
                        hintText: "LTB 8888",
                        labelText: "Vehicle Number",
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Select Date",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: context.width - 35,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Wrap(
                                spacing: 3,
                                direction: Axis.horizontal,
                                children: dateSelectChips(),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        "Select arrival time",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100.0,
                            child: TextField(
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 45.0, color: Colors.black),
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('^(1[0-2]|0?[1-9])'))
                              ],
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: TColor.placeholder,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                            ),
                          ),
                          const Text(
                            ":",
                            style: TextStyle(fontSize: 50),
                          ),
                          SizedBox(
                            width: 100.0,
                            child: TextField(
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 45.0, color: Colors.black),
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^([0-5]?\d)'))
                              ],
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: TColor.placeholder,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                            ),
                          ),
                          Wrap(
                            spacing: 3,
                            direction: Axis.vertical,
                            children: timeChips(),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.alarm,
                            color: TColor.secondaryText,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            "Alarm before 20 minutes",
                            style: TextStyle(color: TColor.secondaryText),
                          ),
                          const Spacer(),
                          Switch(
                              activeColor: TColor.primary,
                              value: isAlarm,
                              onChanged: (value) {
                                setState(() {
                                  isAlarm = value;
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 135,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: RoundButton(
                titleColor: TColor.primaryTextW,
                backgroundColor: TColor.primary,
                title: "Book Spot",
                onPressed: () {
                  Navigator.push(context, PaymentPage.route());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: RoundButton(
                titleColor: TColor.secondaryText,
                backgroundColor: Colors.transparent,
                title: "Cancel",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> dateSelectChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _selectDateChipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: ChoiceChip(
          showCheckmark: false,
          label: Text(_selectDateChipsList[i]),
          labelStyle: (selectedDataIndex != i)
              ? TextStyle(color: TColor.secondaryText)
              : const TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: TColor.bg,
          selectedColor: TColor.primary,
          selected: selectedDataIndex == i,
          onSelected: (bool value) {
            setState(() {
              selectedDataIndex = i;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  List<Widget> timeChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _dNChipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: ChoiceChip(
          showCheckmark: false,
          label: Text(_dNChipsList[i]),
          labelStyle: (selectedTimeIndex != i)
              ? TextStyle(color: TColor.secondaryText)
              : const TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          backgroundColor: TColor.bg,
          selectedColor: TColor.primary,
          selected: selectedTimeIndex == i,
          onSelected: (bool value) {
            setState(() {
              selectedTimeIndex = i;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}

/*showPicker(
                    borderRadius:0,
                    elevation:0,
                    height: 140,
                    wheelHeight:80,
                    isInlinePicker: true,
                    value: _time,
                    onChange: onTimeChanged,
                    iosStylePicker: true,
                    minHour: 0,
                    maxHour: 23,
                    is24HrFormat: false,
                    displayHeader:false,
                    hideButtons:true,
                    dialogInsetPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    contentPadding :const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  ),*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common_model/parking_details_model.dart';
import 'package:mawqifi/common_model/vehicle_model.dart';
import 'package:mawqifi/common_widget/round_button.dart';
import 'package:mawqifi/common_widget/snack_bar_widget.dart';
import 'package:mawqifi/features/booking/presentation/cubit/booking/booking_cubit.dart';
import 'package:mawqifi/features/booking/presentation/page/booking_result_page.dart';
import 'package:quickalert/quickalert.dart';

class BookingPage extends StatefulWidget {
  const BookingPage(
      {super.key, required this.parkingDetailsModel, required this.parkingId});

  final ParkingDetailsModel? parkingDetailsModel;
  final int parkingId;

  static route(int parkingId, ParkingDetailsModel? parkingDetailsModel) =>
      MaterialPageRoute(
        builder: (context) => BookingPage(
          parkingDetailsModel: parkingDetailsModel,
          parkingId: parkingId,
        ),
      );

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;
  int selectTimeOption = 0;
  bool isArrivalNow = false;
  final List _selectDateChipsList = [
    "Today",
    "Tomorrow",
  ];
  final List _dNChipsList = [
    "AM",
    "PM",
  ];

  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();

  final _hourKey = GlobalKey<FormState>(debugLabel: "hour");
  final _minuteKey = GlobalKey<FormState>(debugLabel: "minute");

  List<VehicleModel> vehicles = [];
  VehicleModel? selectedVehicle;

  @override
  void initState() {
    context
        .read<BookingCubit>()
        .getVehicle(Globs.udValueInt(PreferenceKey.userId));
    super.initState();
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
      body: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is BookingHUDState) {
            Globs.showHUD();
          } else if (state is BookingErrorState) {
            Globs.hideHUD();
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Error',
              text: state.errorMessage,
              backgroundColor: Colors.black,
              titleColor: Colors.white,
              textColor: Colors.white,
            );
          } else if (state is BookingGetProfileVehicleApiResultState) {
            Globs.hideHUD();
            vehicles = state.vehicles;
          } else if (state is BookingSubmitApiResultState) {
            Globs.hideHUD();
            Navigator.pushReplacement(context, BookingResultPage.route(state.bookingSubmitModel));
          } else if (state is BookingErrorApiResultState) {
            Globs.hideHUD();
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: state.errorResponse.statusCode.toString(),
              text: state.errorResponse.message,
              backgroundColor: Colors.black,
              titleColor: Colors.white,
              textColor: Colors.white,
            );
          }
        },
        builder: (context, state) {
          return Column(
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
                          DropdownButtonFormField(
                              items: vehicles.map((VehicleModel vehicle) {
                                return DropdownMenuItem(
                                    alignment: Alignment.center,
                                    value: vehicle,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                            "${vehicle.brand}, ${vehicle.model}, ${vehicle.plantNo}"),
                                      ],
                                    ));
                              }).toList(),
                              onChanged: (newValue) {
                                // do other stuff with _category
                                setState(() => selectedVehicle = newValue);
                              },
                              value: selectedVehicle,
                              decoration: InputDecoration(
                                hintText: "Mahindra Thar",
                                labelText: "Select Vehicle",
                                helperStyle: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              validator: (p0) {
                                if (p0 == null) {
                                  return "Vehicle can't be null";
                                } else {
                                  return null;
                                }
                              }),
                          const SizedBox(
                            height: 16,
                          ),
                          (!isArrivalNow)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Select Date",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
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
                                  ],
                                )
                              : const Column(),
                          Row(
                            children: [
                              const Text(
                                "Select arrival time",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              const Spacer(),
                              const Text(
                                "Now",
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Switch(
                                  activeColor: TColor.primary,
                                  value: isArrivalNow,
                                  onChanged: (value) {
                                    setState(() {
                                      isArrivalNow = value;
                                    });
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          (!isArrivalNow)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 100.0,
                                      child: Form(
                                        key: _hourKey,
                                        child: TextFormField(
                                          controller: hourController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "";
                                            } else {
                                              return null;
                                            }
                                          },
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 45.0,
                                              color: Colors.black),
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
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      ":",
                                      style: TextStyle(fontSize: 50),
                                    ),
                                    SizedBox(
                                      width: 100.0,
                                      child: Form(
                                        key: _minuteKey,
                                        child: TextFormField(
                                          controller: minuteController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "";
                                            } else {
                                              return null;
                                            }
                                          },
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 45.0,
                                              color: Colors.black),
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
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Wrap(
                                      spacing: 3,
                                      direction: Axis.vertical,
                                      children: timeChips(),
                                    )
                                  ],
                                )
                              : const Row(),
                          const SizedBox(
                            height: 6,
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
                              itemCount: widget.parkingDetailsModel
                                  ?.availableTimeSlices.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectTimeOption = index;
                                    });
                                  },
                                  child: Card(
                                    color: (selectTimeOption == index)
                                        ? TColor.secondaryText
                                        : null,
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
                                            Text(
                                                "${widget.parkingDetailsModel?.availableTimeSlices[index]} \$"),
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
            ],
          );
        },
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
                  if (selectedVehicle == null) {
                    SnackBarWidget().get(
                      context,
                      null,
                      "Please Select Your Vehicle First",
                    );
                  } else if (!isArrivalNow &&
                      (!_hourKey.currentState!.validate() &&
                          !_minuteKey.currentState!.validate())) {
                    SnackBarWidget().get(
                      context,
                      null,
                      "Please Select Your Arrive Time",
                    );
                  } else {
                    var from = DateTime.now();
                    if (!isArrivalNow) {
                      from.add(Duration(days: selectedDateIndex));
                      var hour = int.parse(hourController.text);
                      if (selectedTimeIndex != 0) {
                        hour = hour + 12;
                        if (hour == 24) {
                          hour = 00;
                        }
                      }
                      from = from.copyWith(
                          hour: hour, minute: int.parse(minuteController.text));
                    }
                    var until = from.add(Duration(hours: selectTimeOption + 1));
                    context.read<BookingCubit>().submitBookSpot(
                        parkingId: widget.parkingId,
                        userId: Globs.udValueInt(PreferenceKey.userId),
                        vehicleId: selectedVehicle?.id,
                        from: from,
                        until: until);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: RoundButton(
                titleColor: TColor.secondaryText,
                backgroundColor: Colors.transparent,
                title: "Cancel",
                onPressed: () {
                  Navigator.pop(context);
                },
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
          labelStyle: (selectedDateIndex != i)
              ? TextStyle(color: TColor.secondaryText)
              : const TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: TColor.bg,
          selectedColor: TColor.primary,
          selected: selectedDateIndex == i,
          onSelected: (bool value) {
            setState(() {
              selectedDateIndex = i;
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

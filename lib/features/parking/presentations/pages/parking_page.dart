import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common/location.dart';
import 'package:mawqifi/common_model/nearby_parking_model.dart';
import 'package:mawqifi/common_widget/nothing_to_show_widget.dart';
import 'package:mawqifi/common_widget/park_item.dart';
import 'package:mawqifi/features/parking/presentations/cubit/parking/parking_cubit.dart';
import 'package:mawqifi/features/parking/presentations/pages/parking_details_page.dart';
import 'package:quickalert/quickalert.dart';

class ParkingPage extends StatefulWidget {
  const ParkingPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const ParkingPage(),
      );

  @override
  State<ParkingPage> createState() => _ParkingPageState();
}

class _ParkingPageState extends State<ParkingPage> {
  @override
  void initState() {
    context.read<ParkingCubit>().getNearbyParking();
    super.initState();
  }

  Timer searchOnStoppedTyping = Timer(
    const Duration(seconds: 5),
    () {},
  );

  _onChangeHandler(value) {
    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping.cancel()); // clear timer
    }
    setState(
        () => searchOnStoppedTyping = Timer(duration, () => search(value)));
  }

  search(value) {
    var s = value as String?;
    if (s == null || s.isEmpty) {
      context.read<ParkingCubit>().getNearbyParking();
    } else {
      context.read<ParkingCubit>().getParkingByName(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<NearbyParkingModel> apiList = [];
    context.read<ParkingCubit>().getNearbyParking();

    return BlocConsumer<ParkingCubit, ParkingState>(
      listener: (context, state) {
        if (state is ParkingHUDState) {
          Globs.showHUD();
        } else if (state is ParkingGetNearbyParkingApiResultState) {
          apiList.clear();
          print(state.nearbyParkingModel);
          apiList.addAll(state.nearbyParkingModel);
          Globs.hideHUD();
        } else if (state is ParkingGetParkingByNameApiResultState) {
          apiList.clear();
          print(state.nearbyParkingModel);
          apiList.addAll(state.nearbyParkingModel);
          Globs.hideHUD();
        } else if (state is ParkingErrorState) {
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
        } else if (state is ParkingLocationPermissionNotEnabledErrorState) {
          Globs.hideHUD();
          QuickAlert.show(
            context: context,
            type: QuickAlertType.warning,
            title: 'Please enable location',
            text: state.errorMessage,
            backgroundColor: Colors.black,
            titleColor: Colors.white,
            textColor: Colors.white,
            onConfirmBtnTap: () async {
              Location.askForLocationPermission();
              Navigator.pop(context);
              context.read<ParkingCubit>().getNearbyParking();
              return;
            },
          );
        } else if (state is ParkingErrorApiResultState) {
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
                  helperStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onChanged: _onChangeHandler,
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
                height: context.height - 330,
                child: (apiList.isNotEmpty) ? ListView.builder(
                  itemCount: apiList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var item = apiList[index];
                    return ParkItem(
                      imageUrl: item.imageUrl,
                      name: item.name,
                      details: item.longAddress,
                      price: item.price,
                      onPressed: () {
                        Navigator.push(
                            context,
                            ParkingDetailsPage.route(
                              item.parkingId,
                            ));
                      },
                    );
                  },
                ):const NothingToShowWidget(),
              ),
            ],
          ),
        );
      },
    );
  }
}

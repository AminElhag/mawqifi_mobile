import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common_model/parking_details_model.dart';
import 'package:mawqifi/common_widget/round_button.dart';
import 'package:mawqifi/features/booking/presentation/page/booking_page.dart';
import 'package:mawqifi/features/parking/presentations/cubit/parking_details/parking_details_cubit.dart';
import 'package:quickalert/quickalert.dart';
import 'package:readmore/readmore.dart';

class ParkingDetailsPage extends StatefulWidget {
  const ParkingDetailsPage({
    super.key,
    required this.parkingId,
  });

  final int parkingId;

  static route(int parkingId) => MaterialPageRoute(
        builder: (context) => ParkingDetailsPage(
          parkingId: parkingId,
        ),
      );

  @override
  State<ParkingDetailsPage> createState() => _ParkingDetailsPageState();
}

class _ParkingDetailsPageState extends State<ParkingDetailsPage> {
  ParkingDetailsModel? parkingDetailsModel;

  @override
  void initState() {
    context.read<ParkingDetailsCubit>().getParkingDetailsById(widget.parkingId);
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
      ),
      body: BlocConsumer<ParkingDetailsCubit, ParkingDetailsState>(
        listener: (context, state) {
          if (state is ParkingDetailsHUDState) {
            Globs.showHUD();
          } else if (state is ParkingDetailsErrorState) {
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
          } else if (state is ParkingDetailsApiResultState) {
            parkingDetailsModel = state.parkingDetailsModel;
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: parkingDetailsModel?.imagesUrl.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var imagesUrl = parkingDetailsModel?.imagesUrl[index];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CachedNetworkImage(
                            height: 200,
                            width: 200,
                            imageUrl: imagesUrl ?? "",
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/img/pictures_error.png",
                              height: 200,
                              width: 200,
                            ),
                          ),
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
                          Text(
                            parkingDetailsModel?.name ?? "",
                            style: const TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                "${parkingDetailsModel?.ratting ?? ""}",
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
                        parkingDetailsModel?.shortAddress ?? "",
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
                                const Icon(Icons.fit_screen),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                    "${parkingDetailsModel?.space ?? "_"} km²"),
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
                                const Icon(Icons.alarm),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                    "${parkingDetailsModel?.startTime ?? ""} AM - ${parkingDetailsModel?.endTime ?? ""} PM"),
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
                            fontWeight: FontWeight.w600,
                            color: TColor.secondaryText),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      ReadMoreText(
                        parkingDetailsModel?.rules ?? "",
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
                            fontWeight: FontWeight.w600,
                            color: TColor.secondaryText),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      ReadMoreText(
                        parkingDetailsModel?.longAddress ?? "",
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
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: RoundButton(
          titleColor: TColor.primaryTextW,
          backgroundColor: TColor.primary,
          title: "Book Parking",
          onPressed: () {
            Navigator.push(
              context,
              BookingPage.route(widget.parkingId,parkingDetailsModel),
            );
          },
        ),
      ),
    );
  }
}

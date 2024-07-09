import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common/location.dart';
import 'package:mawqifi/common_model/booking_a_spot_model.dart';
import 'package:mawqifi/common_model/booking_details_model.dart';
import 'package:mawqifi/common_widget/booking_progress_button.dart';
import 'package:mawqifi/common_widget/curved_edges.dart';
import 'package:mawqifi/common_widget/round_button.dart';
import 'package:mawqifi/features/booking/presentation/cubit/booking_details/booking_details_cubit.dart';
import 'package:mawqifi/features/main/presentations/page/main_page.dart';
import 'package:quickalert/quickalert.dart';

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({super.key, required this.bookingId});

  final int bookingId;

  static route(int bookingId) => MaterialPageRoute(
        builder: (context) => BookingDetailsPage(
          bookingId: bookingId,
        ),
      );

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage>
    with OSMMixinObserver {
  BookingDetailsModel? bookingDetails;

  MapController controller = MapController.withUserPosition(
      trackUserLocation: const UserTrackingOption(
        enableTracking: true,
        unFollowUser: false,
      )
  );

  @override
  void initState() {
    context
        .read<BookingDetailsCubit>()
        .getBookingDetailsById(widget.bookingId);
    Location.getLocation().then(
      (value) async {
        await controller.moveTo(GeoPoint(latitude: value.latitude, longitude: value.longitude),animate:true);
      },
    );
    controller.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<BookingDetailsCubit>()
        .getBookingDetailsById(widget.bookingId);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context,MainPage.route());
              },
              icon: const Icon(Icons.arrow_back_rounded)),
        title: const Text(
          "Enter Details",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<BookingDetailsCubit, BookingDetailsState>(
        listener: (context, state) {
          if (state is BookingDetailsHUDState) {
            Globs.showHUD();
          } else if (state is BookingDetailsErrorState) {
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
          } else if (state is BookingDetailsErrorApiResultState) {
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
          } else if (state
              is BookingDetailsGetBookingDetailsByIdApiResultState) {
            Globs.hideHUD();
            if (kDebugMode) {
              print(state.bookingDetails);
            }
            bookingDetails = state.bookingDetails;
          } else if (state is BookingDetailsCanceledState || state is BookingDetailsCompletedState){
            context
                .read<BookingDetailsCubit>()
                .getBookingDetailsById(widget.bookingId);
          }
        },
        builder: (context, state) {
          return (bookingDetails != null)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipPath(
                      clipper: TCustomCurvedEdges(),
                      child: SizedBox(
                        width: context.width,
                        height: 350,
                        child: OSMFlutter(
                          controller: controller,
                          osmOption: OSMOption(
                            userTrackingOption: const UserTrackingOption(
                              enableTracking: true,
                              unFollowUser: false,
                            ),
                            zoomOption: const ZoomOption(
                              initZoom: 8,
                              minZoomLevel: 3,
                              maxZoomLevel: 19,
                              stepZoom: 1.0,
                            ),
                            userLocationMarker: UserLocationMaker(
                              personMarker: const MarkerIcon(
                                icon: Icon(
                                  Icons.location_history_rounded,
                                  color: Colors.red,
                                  size: 48,
                                ),
                              ),
                              directionArrowMarker: const MarkerIcon(
                                icon: Icon(
                                  Icons.double_arrow,
                                  size: 48,
                                ),
                              ),
                            ),
                            roadConfiguration: const RoadOption(
                              roadColor: Colors.yellowAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        bookingDetails!.parking.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              bookingDetails!.parking.longAddress,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 18),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: MaterialButton(
                              onPressed: () {
                                Location.launchGoogleMaps(bookingDetails!.parking.latitude, bookingDetails!.parking.longitude);
                              },
                              minWidth: double.minPositive,
                              elevation: 0,
                              color: TColor.lightGray,
                              height: 40,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Row(
                                children: [
                                  Text("Navigation"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        (bookingDetails!.driver == null)
                            ? "Waiting to accept"
                            : (bookingDetails!.statusId ==
                                    BookingProgress.wanting.index)
                                ? "Driver is waiting"
                                : (bookingDetails!.statusId ==
                                        BookingProgress.inProgress.index)
                                    ? "Your car in the parking"
                                    : (bookingDetails!.statusId ==
                                            BookingProgress.completed.index)
                                        ? "Everything is Good"
                                        : (bookingDetails!.statusId ==
                                                BookingProgress.canceled.index)
                                            ? "This parking has be canceled"
                                            : "",
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 18),
                      ),
                    ),
                    const Spacer(),
                    (bookingDetails!.statusId ==
                                BookingProgress.canceled.index ||
                            bookingDetails!.statusId ==
                                BookingProgress.completed.index)
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RoundButton(
                                title: (bookingDetails!.statusId ==
                                        BookingProgress.wanting.index)
                                    ? "Canceled"
                                    : (bookingDetails!.statusId ==
                                            BookingProgress.inProgress.index)
                                        ? "Request you car"
                                        : "",
                                onPressed: () {
                                  (bookingDetails!.statusId ==
                                      BookingProgress.wanting.index)
                                      ? context.read<BookingDetailsCubit>().canceled(bookingDetails!.bookingId)
                                      : (bookingDetails!.statusId ==
                                      BookingProgress.inProgress.index)
                                      ? context.read<BookingDetailsCubit>().completed(bookingDetails!.bookingId)
                                      : null;
                                },
                                backgroundColor: TColor.primary,
                                titleColor: TColor.secondaryText),
                          )
                  ],
                )
              : const SizedBox();
        },
      ),
    );
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    if (isReady) {
      addMarker();
    }
  }

  void addMarker() async {
    Location.getLocation().then(
      (value) async {
        await controller.setMarkerOfStaticPoint(
            id: "pickup",
            markerIcon: const MarkerIcon(
              iconWidget: Icon(
                Icons.pin_drop_sharp,
                color: Colors.blue,
              ),
            ));
        await controller.setStaticPosition(
            [GeoPoint(latitude: value.longitude, longitude: value.longitude)],
            "pickup");
      },
    );
  }
}

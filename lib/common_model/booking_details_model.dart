import 'package:mawqifi/common_model/nearby_parking_model.dart';
import 'package:mawqifi/common_model/parking_details_model.dart';
import 'package:mawqifi/common_model/vehicle_model.dart';

import 'driver_model.dart';

class BookingDetailsModel {
  final VehicleModel vehicle;
  final NearbyParkingModel parking;
  final String from;
  final String to;
  final int statusId;
  final int bookingId;
  final DriverModel? driver;

  BookingDetailsModel(
      {required this.vehicle,
      required this.parking,
      required this.from,
      required this.to,
      required this.statusId,
      required this.bookingId,
      required this.driver});

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) =>
      BookingDetailsModel(
          vehicle: VehicleModel.fromJson(json['vehicle']),
          parking: NearbyParkingModel.fromJson(json['parking']),
          from: json['from'],
          to: json['to'],
          statusId: json['status_id'],
          bookingId: json['booking_id'],
          driver: (json['driver'] == null) ? null : DriverModel.fromJson(json['driver']));
}

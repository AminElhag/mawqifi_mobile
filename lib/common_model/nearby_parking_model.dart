import 'dart:ffi';

class NearbyParkingModel {
  NearbyParkingModel(
      {required this.parkingId,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.longAddress});

  final int parkingId;
  final String name;
  final double price;
  final String? imageUrl;
  final String longAddress;

  factory NearbyParkingModel.fromJson(Map<String, dynamic> json) =>
      NearbyParkingModel(
        parkingId: json['parking_id'],
        name: json['name'],
        price: json['price'],
        imageUrl: json['big_image'],
        longAddress: json['long_address'],
      );
}

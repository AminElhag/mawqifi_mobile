

class NearbyParkingModel {
  NearbyParkingModel(
      {required this.parkingId,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.longAddress,
      required this.longitude,
      required this.latitude});

  final int parkingId;
  final String name;
  final double price;
  final String? imageUrl;
  final String longAddress;
  final double latitude;
  final double longitude;

  factory NearbyParkingModel.fromJson(Map<String, dynamic> json) =>
      NearbyParkingModel(
        parkingId: json['parking_id'],
        name: json['name'],
        price: json['price'],
        imageUrl: json['big_image'],
        longAddress: json['long_address'],
        longitude: json['lon'],
        latitude: json['lat']
      );
}

class NearbyParkingModel {
  NearbyParkingModel(
      {required this.name,
      required this.description,
      required this.distance,
      required this.typeId,
      required this.statusId,
      required this.price,
      required this.imageUrl});

  final String name;
  final String description;
  final double distance;
  final int typeId;
  final int statusId;
  final double price;
  final String? imageUrl;

  factory NearbyParkingModel.fromJson(Map<String, dynamic> json) =>
      NearbyParkingModel(
        name: json['name'],
        description: json['description'],
        distance: json['distance'],
        typeId: json['typeId'],
        statusId: json['statusId'],
        price: json['price'],
        imageUrl: json['imageUrl']
      );
}

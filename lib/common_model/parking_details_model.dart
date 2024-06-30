class ParkingDetailsModel {
  final List<String> imagesUrl;
  final String name;
  final double ratting;
  final String shortAddress;
  final double space;
  final int startTime;
  final int endTime;
  final String rules;
  final String longAddress;
  final double price;
  final List<double> availableTimeSlices;

  ParkingDetailsModel({
    required this.availableTimeSlices,
    required this.imagesUrl,
    required this.name,
    required this.ratting,
    required this.shortAddress,
    required this.space,
    required this.startTime,
    required this.endTime,
    required this.rules,
    required this.longAddress,
    required this.price,
  });

  factory ParkingDetailsModel.fromJson(Map<String, dynamic> json) =>
      ParkingDetailsModel(
          imagesUrl: json['images_url'].cast<String>(),
          name: json['name'],
          ratting: json['ratting'],
          shortAddress: json['short_address'],
          space: json['space'],
          startTime: json['start_time'],
          endTime: json['end_time'],
          rules: json['rules'],
          longAddress: json['long_address'],
          price: json['price'],
          availableTimeSlices: json['available_time_slices'].cast<double>());
}

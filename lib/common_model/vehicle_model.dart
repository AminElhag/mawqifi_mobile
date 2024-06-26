class VehicleModel {
  const VehicleModel(
      {required this.id,
      required this.carTypeId,
      required this.color,
      required this.model,
      required this.brand,
      required this.plantNo});

  final int id;
  final String brand;
  final String model;
  final String plantNo;
  final String color;
  final int carTypeId;

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        id: json['vehicle_id'],
        carTypeId: json['car_type'],
        color: json['color'],
        plantNo: json['plant_no'],
        model: json['model'],
        brand: json['brand'],
      );
}

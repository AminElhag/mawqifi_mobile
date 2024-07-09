/*
* val id: Long = 0,
    val phoneNumber: String = "",
    val fullName: String = "",
    val homeAddress: String = "",
    val genderTypeId: Int = 0,
    val platformDeviceId: String = "",
    val platformType: String = "Unknown",
    val createAt: Date? = null,
    val updateAt: Date? = null,
    val fcmToken: String = "",
    val parkingId: Long? = null,*/
class DriverModel {
  final int id;
  final String phoneNumber;
  final String fullName;

  DriverModel(
      {required this.id, required this.phoneNumber, required this.fullName});

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
      id: json["id"],
      phoneNumber: json['phoneNumber'],
      fullName: json['fullName']);
}

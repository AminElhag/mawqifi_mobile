class ProfileModel {
  const ProfileModel({
    required this.phoneNumber,
    required this.fullName,
    required this.homeAddress,
    required this.genderTypeId,
  });

  final String phoneNumber;
  final String fullName;
  final String homeAddress;
  final int genderTypeId;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        phoneNumber: json['phone_number'],
        fullName: json['full_name'],
        homeAddress: json['home_address'],
        genderTypeId: json['gender_type_id'],
      );
}

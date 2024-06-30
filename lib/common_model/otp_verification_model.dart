import 'package:mawqifi/common_model/profile_model.dart';

class OtpVerificationModel {
  OtpVerificationModel(
      {required this.isValid, required this.token, required this.profile});

  final bool isValid;
  final String? token;
  final ProfileModel? profile;

  factory OtpVerificationModel.fromJson(Map<String, dynamic> json) =>
      OtpVerificationModel(
        isValid: json['is_valid'],
        token: json['token'],
        profile: (json['profile'] != null)
            ? ProfileModel.fromJson(json['profile'])
            : null,
      );
}

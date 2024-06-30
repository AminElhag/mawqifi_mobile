import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common/service_call.dart';
import 'package:mawqifi/common_model/error_response.dart';
import 'package:mawqifi/common_model/otp_verification_model.dart';
import 'package:mawqifi/common_model/profile_model.dart';
import 'package:meta/meta.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

  void otpSubmit(String phoneNumber, String otp) {
    try {
      emit(OtpHUDState());
      ServiceCall.post(
        {"phone_number": phoneNumber, "otp": otp},
        SVKey.svOtp,
        withFailure: (response) async {
          emit(OtpErrorState(response));
        },
        withSuccess: (response) async {
          if (response.statusCode == HttpStatus.ok) {
            var otpVerificationModel = OtpVerificationModel.fromJson(jsonDecode(response.body));
            if(otpVerificationModel.isValid){
              if(otpVerificationModel.token!.isNotEmpty){
                Globs.udStringSet(otpVerificationModel.token!, PreferenceKey.token);
              }
              if (otpVerificationModel.profile == null) {
                print("no profile create a new one");
                emit(OtpWithoutProfileApiResultState());
                emit(OtpInitial());
              }else{
                emit(OtpWithProfileApiResultState(
                    otpVerificationModel: otpVerificationModel));
                emit(OtpInitial());
              }
            }else{
              emit(const OtpErrorState("OTP is not valid"));
            }
          } else {
            emit(OtpErrorApiResultState(ErrorResponse.fromJson(
              jsonDecode(response.body),
            )));
          }
        },
      );
    } catch (e) {
      emit(OtpErrorState(e.toString()));
    }
  }

  void resendOtp(String mobileNumber) {
    try {
      emit(OtpHUDState());
      ServiceCall.post(
        {
          "phone_number": mobileNumber,
          "os_type": (Platform.isAndroid)
              ? "Android"
              : (Platform.isIOS)
                  ? "IOS"
                  : "Unknown",
        },
        SVKey.svMobileLogin,
        withSuccess: (response) async {
          if (response.statusCode == HttpStatus.ok) {
            emit(ResendOtpApiResultState());
            emit(OtpInitial());
          } else {
            emit(OtpErrorState(response.reasonPhrase ?? "Unknown error"));
          }
        },
        withFailure: (response) async {
          emit(OtpErrorState(response));
        },
      );
    } catch (e) {
      emit(OtpErrorState(e.toString()));
    }
  }
}

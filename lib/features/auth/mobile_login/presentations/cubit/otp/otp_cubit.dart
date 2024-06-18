import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common/service_call.dart';
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
            if (response.body.contains("true")) {
              print("------------------------------------------------------");
              print(response.body);
              emit(OtpApiResultState());
              emit(OtpInitial());
            } else {
              print("------------------------------------------------------");
              print(response.body);
              emit(const OtpErrorState("Otp is not valid !"));
            }
          } else {
            emit(OtpErrorState(response.reasonPhrase ?? "Unknown error"));
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
            emit(OtpErrorState(
                response.reasonPhrase ?? "Unknown error"));
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

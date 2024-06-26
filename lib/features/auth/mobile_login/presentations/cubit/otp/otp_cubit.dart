import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common/service_call.dart';
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
            if(response.body.isEmpty){
              print("no profile create a new one");
              emit(OtpWithoutProfileApiResultState());
              emit(OtpInitial());
            }else{
              print("profile has found don't create a new one");
              var otpResponse = ProfileModel.fromJson(jsonDecode(response.body));
              emit(OtpWithProfileApiResultState(profileModel: otpResponse));
              emit(OtpInitial());
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

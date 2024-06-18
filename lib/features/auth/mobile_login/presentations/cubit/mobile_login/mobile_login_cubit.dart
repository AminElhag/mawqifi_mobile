import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common/service_call.dart';
import 'package:meta/meta.dart';

part 'mobile_login_state.dart';

class MobileLoginCubit extends Cubit<MobileLoginState> {
  MobileLoginCubit() : super(MobileLoginInitial());

  void phoneNumberLogin(String mobileNumber) {
    try {
      emit(MobileLoginHUDState());
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
            emit(MobileLoginApiResultState());
            emit(MobileLoginInitial());
          } else {
            emit(MobileLoginErrorState(
                response.reasonPhrase ?? "Unknown error"));
          }
        },
        withFailure: (response) async {
          emit(MobileLoginErrorState(response));
        },
      );
    } catch (e) {
      emit(MobileLoginErrorState(e.toString()));
    }
  }
}

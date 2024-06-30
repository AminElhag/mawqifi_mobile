import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common/service_call.dart';
import 'package:mawqifi/common_model/error_response.dart';
import 'package:mawqifi/common_model/profile_model.dart';
import 'package:meta/meta.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';

part 'create_profile_state.dart';

class CreateProfileCubit extends Cubit<CreateProfileState> {
  CreateProfileCubit() : super(CreateProfileInitial());

  void profileSubmit(String phoneNumber, String fullName, String homeAddress,
      int genderTypeId) async {
    try {
      emit(CreateProfileHUDState());
      ServiceCall.post(
        {
          "phone_number": phoneNumber,
          "full_name": fullName,
          "home_address": homeAddress,
          "gender_type_id": genderTypeId,
          "platform_device_id": await PlatformDeviceId.getDeviceId,
          "platform_type": (Platform.isAndroid)
              ? "Android"
              : (Platform.isIOS)
                  ? "IOS"
                  : "Unknown",
        },
        SVKey.svCreateProfile,
        isTokenApi: true,
        withFailure: (response) async {
          emit(CreateProfileErrorState(response.toString()));
        },
        withSuccess: (response) async {
          if (response.statusCode == HttpStatus.created) {
            emit(CreateProfileApiResultState(
                ProfileModel.fromJson(jsonDecode(response.body))));
            emit(CreateProfileInitial());
          } /*else if (response.statusCode == HttpStatus.found) {
            emit(const CreateProfileErrorState("This user is already found"));
          }*/ else {
            emit(CreateProfileErrorApiResultState(
                ErrorResponse.fromJson(jsonDecode(response.body))));
          }
        },
      );
    } catch (e) {
      emit(CreateProfileErrorState(e.toString()));
    }
  }
}

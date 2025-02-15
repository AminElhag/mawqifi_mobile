import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common/service_call.dart';
import 'package:mawqifi/common_model/error_response.dart';

part 'add_vehicle_state.dart';

class AddVehicleCubit extends Cubit<AddVehicleState> {
  AddVehicleCubit() : super(AddVehicleInitial());

  void addVehicleSubmit(
      String brand, String model, String platNo, String color, int carTypeId,
      [int? id]) async {
    try {
      emit(AddVehicleHUDState());
      ServiceCall.post(
        {
          "id": id,
          "brand": brand,
          "model": model,
          "plant_no": platNo,
          "color": color,
          "car_type_id": carTypeId,
          "phone_number": Globs.udValueString(PreferenceKey.phoneNumber),
        },
        SVKey.svVehicle,
        isTokenApi: true,
        withFailure: (error) async {
          emit(AddVehicleErrorState(error));
        },
        withSuccess: (response) async {
          if (response.statusCode == HttpStatus.created) {
            emit(AddVehicleApiResultState());
            emit(AddVehicleInitial());
          } /*else if (response.statusCode == HttpStatus.found) {
            emit(const AddVehicleErrorState("This user is already found"));
          }*/ else {
            emit(AddVehicleErrorApiResultState(
                ErrorResponse.fromJson(jsonDecode(response.body))));
          }
        },
      );
    } catch (e) {
      emit(AddVehicleErrorState(e.toString()));
    }
  }
}

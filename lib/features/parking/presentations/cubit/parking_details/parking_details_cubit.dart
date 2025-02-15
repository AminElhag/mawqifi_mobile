import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common/service_call.dart';
import 'package:mawqifi/common_model/error_response.dart';
import 'package:mawqifi/common_model/parking_details_model.dart';
import 'package:meta/meta.dart';

part 'parking_details_state.dart';

class ParkingDetailsCubit extends Cubit<ParkingDetailsState> {
  ParkingDetailsCubit() : super(ParkingDetailsInitial());

  void getParkingDetailsById(int parkingId) {
    try {
      ServiceCall.get(
        {"parking_id": parkingId.toString()},
        SVKey.svGetParkingDetails,
        isTokenApi: true,
        withFailure: (response) async {
          emit(ParkingDetailsErrorState(response));
        },
        withSuccess: (response) async {
          if (response.statusCode == HttpStatus.ok) {
            emit(ParkingDetailsApiResultState(
                parkingDetailsModel:
                    ParkingDetailsModel.fromJson(json.decode(response.body))));
            emit(ParkingDetailsInitial());
          } else {
            emit(ParkingDetailsErrorApiResultState(
                ErrorResponse.fromJson(json.decode(response.body))));
            emit(ParkingDetailsInitial());
          }
        },
      );
    } catch (e) {
      emit(ParkingDetailsErrorState(e.toString()));
    }
  }
}

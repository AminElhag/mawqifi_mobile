import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common/service_call.dart';
import 'package:mawqifi/common_model/error_response.dart';
import 'package:mawqifi/common_model/vehicle_model.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  void getVehicle(int userId) {
    try {
      emit(BookingHUDState());
      ServiceCall.get(
        {
          "user_id": userId.toString(),
        },
        SVKey.svVehicle,
        withFailure: (response) async {
          emit(BookingErrorState(response));
        },
        withSuccess: (response) async {
          print(response.body);
          if (response.statusCode == HttpStatus.ok) {
            Iterable l = json.decode(response.body);
            List<VehicleModel> nps = List<VehicleModel>.from(
                l.map((model) => VehicleModel.fromJson(model)));
            emit(BookingGetProfileVehicleApiResultState(vehicles: nps));
            emit(BookingInitial());
          } else {
            emit(BookingErrorApiResultState(
                ErrorResponse.fromJson(jsonDecode(response.body))));
          }
        },
      );
    } catch (e) {
      emit(BookingErrorState(e.toString()));
    }
  }

  void submitBookSpot(
      {required int parkingId,
      required int userId,
      int? vehicleId,
      required DateTime from,
      required DateTime until}) {
    try {
      emit(BookingHUDState());
      ServiceCall.post(
        {
          "parking_id": parkingId.toString(),
          "user_id": userId.toString(),
          "vehicle_id": vehicleId.toString(),
          "from": from.toUtc().toString(),
          "until": until.toUtc().toString(),
        },
        SVKey.svBooking,
        withFailure: (response) async {
          emit(BookingErrorState(response));
        },
        withSuccess: (response) async {
          if (kDebugMode) {
            print(response.body);
          }
          if (response.statusCode == HttpStatus.ok) {
            emit(BookingSubmitApiResultState());
            emit(BookingInitial());
          } else {
            emit(BookingErrorApiResultState(
                ErrorResponse.fromJson(jsonDecode(response.body))));
          }
        },
      );
    } catch (e) {
      emit(BookingErrorState(e.toString()));
    }
  }
}

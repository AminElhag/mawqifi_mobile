import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common/location.dart';
import 'package:mawqifi/common/service_call.dart';
import 'package:mawqifi/common_model/nearby_parking_model.dart';
import 'package:meta/meta.dart';

part 'parking_state.dart';

class ParkingCubit extends Cubit<ParkingState> {
  ParkingCubit() : super(ParkingInitial());

  void getNearbyParking() {
    try {
      emit(ParkingHUDState());
      Location.getLocation().then(
        (position) {
          ServiceCall.get(
            {
              "latitude": position.latitude.toString(),
              "longitude": position.longitude.toString()
            },
            SVKey.svGetNearbyParking,
            withFailure: (response) async {
              emit(ParkingErrorState(response));
            },
            withSuccess: (response) async {
              if (response.statusCode == HttpStatus.ok) {
                Iterable l = json.decode(response.body);
                List<NearbyParkingModel> nps = List<NearbyParkingModel>.from(
                    l.map((model) => NearbyParkingModel.fromJson(model)));
                emit(ParkingGetNearbyParkingApiResultState(
                    nearbyParkingModel: nps));
                emit(ParkingInitial());
              } else {
                emit(ParkingErrorState(response.reasonPhrase ?? "Unknown error"));
              }
            },
          );
        },
      );
    } catch (e) {
      emit(ParkingErrorState(e.toString()));
    }
  }

  void getParkingByName(name) {
    try {
      emit(ParkingHUDState());
      Location.getLocation().then(
        (position) {
          ServiceCall.get(
            {
              "name": name,
              "latitude": position.latitude.toString(),
              "longitude": position.longitude.toString(),
            },
            SVKey.svGetNearbyParking,
            withFailure: (response) async {
              emit(ParkingErrorState(response.toString()));
            },
            withSuccess: (response) async {
              if (response.statusCode == HttpStatus.ok) {
                Iterable l = json.decode(response.body);
                List<NearbyParkingModel> nps = List<NearbyParkingModel>.from(
                    l.map((model) => NearbyParkingModel.fromJson(model)));
                emit(ParkingGetParkingByNameApiResultState(
                    nearbyParkingModel: nps));
                emit(ParkingInitial());
              } else {
                emit(ParkingErrorState(response.reasonPhrase ?? "Unknown error"));
              }
            },
          );
        },
      );
    } catch (e) {
      emit(ParkingErrorState(e.toString()));
    }
  }
}

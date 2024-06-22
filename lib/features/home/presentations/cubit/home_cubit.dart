import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common/location.dart';
import 'package:mawqifi/common/service_call.dart';
import 'package:mawqifi/common_model/nearby_parking_model.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void getNearbyParking() {
    try {
      emit(HomeHUDState());
      Location.getLocation().then(
        (position) {
          ServiceCall.get(
            {
              "latitude": position.latitude.toString(),
              "longitude": position.longitude.toString()
            },
            SVKey.svGetNearbyParking,
            withFailure: (response) async {
              emit(HomeErrorState(response));
            },
            withSuccess: (response) async {
              if (response.statusCode == HttpStatus.ok) {
                Iterable l = json.decode(response.body);
                List<NearbyParkingModel> nps = List<NearbyParkingModel>.from(
                    l.map((model) => NearbyParkingModel.fromJson(model)));
                emit(HomeGetNearbyParkingApiResultState(
                    nearbyParkingModel: nps));
                emit(HomeInitial());
              } else {
                emit(HomeErrorState(response.reasonPhrase ?? "Unknown error"));
              }
            },
          );
        },
      );
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  void getParkingByName(name) {
    try {
      emit(HomeHUDState());
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
              emit(HomeErrorState(response.toString()));
            },
            withSuccess: (response) async {
              if (response.statusCode == HttpStatus.ok) {
                Iterable l = json.decode(response.body);
                List<NearbyParkingModel> nps = List<NearbyParkingModel>.from(
                    l.map((model) => NearbyParkingModel.fromJson(model)));
                emit(HomeGetParkingByNameApiResultState(
                    nearbyParkingModel: nps));
                emit(HomeInitial());
              } else {
                emit(HomeErrorState(response.reasonPhrase ?? "Unknown error"));
              }
            },
          );
        },
      );
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }
}

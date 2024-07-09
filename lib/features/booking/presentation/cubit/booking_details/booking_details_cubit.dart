import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common/service_call.dart';
import 'package:mawqifi/common_model/booking_details_model.dart';
import 'package:mawqifi/common_model/error_response.dart';

part 'booking_details_state.dart';

class BookingDetailsCubit extends Cubit<BookingDetailsState> {
  BookingDetailsCubit() : super(BookingDetailsInitial());

  void getBookingDetailsById(int bookingId) {
    try {
      emit(BookingDetailsHUDState());
      ServiceCall.get(
        {"booking_id": bookingId.toString()},
        SVKey.svBookingDetails,
        isTokenApi: true,
        withFailure: (response) async {
          emit(BookingDetailsErrorState(response.toString()));
        },
        withSuccess: (response) async {
          if (response.statusCode == HttpStatus.ok) {
            emit(BookingDetailsGetBookingDetailsByIdApiResultState(bookingDetails: BookingDetailsModel.fromJson(jsonDecode(response.body))));
            emit(BookingDetailsInitial());
          } else {
            print(response.body);
            emit(BookingDetailsErrorApiResultState(
                ErrorResponse.fromJson(jsonDecode(response.body))));
          }
        },
      );
    } catch (e) {
      emit(BookingDetailsErrorState(e.toString()));
    }
  }

  canceled(int bookingId) {
    try {
      emit(BookingDetailsHUDState());
      ServiceCall.post(
        {"id": bookingId.toString()},
        SVKey.svBookingCanceled,
        isTokenApi: true,
        withFailure: (response) async {
          emit(BookingDetailsErrorState(response.toString()));
        },
        withSuccess: (response) async {
          if (response.statusCode == HttpStatus.ok) {
            emit(BookingDetailsCanceledState());
            emit(BookingDetailsInitial());
          } else {
            print(response.body);
            emit(BookingDetailsErrorApiResultState(
                ErrorResponse.fromJson(jsonDecode(response.body))));
          }
        },
      );
    } catch (e) {
      emit(BookingDetailsErrorState(e.toString()));
    }
  }

  completed(int bookingId) {
    try {
      emit(BookingDetailsHUDState());
      ServiceCall.post(
        {"id": bookingId.toString()},
        SVKey.svBookingComplete,
        isTokenApi: true,
        withFailure: (response) async {
          emit(BookingDetailsErrorState(response.toString()));
        },
        withSuccess: (response) async {
          if (response.statusCode == HttpStatus.ok) {
            emit(BookingDetailsCompletedState());
            emit(BookingDetailsInitial());
          } else {
            print(response.body);
            emit(BookingDetailsErrorApiResultState(
                ErrorResponse.fromJson(jsonDecode(response.body))));
          }
        },
      );
    } catch (e) {
      emit(BookingDetailsErrorState(e.toString()));
    }
  }
}

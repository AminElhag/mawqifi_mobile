import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common/service_call.dart';
import 'package:mawqifi/common_model/booking_item_model.dart';
import 'package:mawqifi/common_model/error_response.dart';

part 'booking_list_state.dart';

class BookingListCubit extends Cubit<BookingListState> {
  BookingListCubit() : super(BookingListInitial());

  void getBookingList(int userId) {
    emit(BookingListHUDState());
    try {
      ServiceCall.get(
        {"profile_id": userId.toString()},
        SVKey.svBooking,
        withFailure: (response) async {
          emit(BookingListErrorState(response));
        },
        withSuccess: (response) async {
          if (kDebugMode) {
            print(response);
          }
          if (response.statusCode == HttpStatus.ok) {
            Iterable l = json.decode(response.body);
            List<BookingItemModel> nps = List<BookingItemModel>.from(
                l.map((model) => BookingItemModel.fromJson(model)));
            emit(BookingListGetListApiResultState(items: nps));
            emit(BookingListInitial());
          } else {
            emit(BookingListErrorApiResultState(
                ErrorResponse.fromJson(jsonDecode(response.body))));
          }
        },
      );
    } catch (e) {
      emit(BookingListErrorState(e.toString()));
    }
  }
}

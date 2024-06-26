part of 'booking_list_cubit.dart';

sealed class BookingListState extends Equatable {
  const BookingListState();

  @override
  List<Object> get props => [];
}

final class BookingListInitial extends BookingListState {}

final class BookingListHUDState extends BookingListState {}

final class BookingListGetListApiResultState extends BookingListState {
  final List<BookingItemModel> items;

  const BookingListGetListApiResultState({required this.items});
}

final class BookingSubmitApiResultState extends BookingListState {}

final class BookingListErrorState extends BookingListState {
  final String errorMessage;

  const BookingListErrorState(this.errorMessage);

  @override
  List<Object> get props => [];
}

final class BookingListErrorApiResultState extends BookingListState {
  final ErrorResponse errorResponse;

  const BookingListErrorApiResultState(this.errorResponse);

  @override
  List<Object> get props => [];
}

part of 'booking_details_cubit.dart';

sealed class BookingDetailsState extends Equatable {
  const BookingDetailsState();

  @override
  List<Object> get props => [];
}

final class BookingDetailsInitial extends BookingDetailsState {}

final class BookingDetailsHUDState extends BookingDetailsState {}

final class BookingDetailsCanceledState extends BookingDetailsState {}

final class BookingDetailsCompletedState extends BookingDetailsState {}

final class BookingDetailsGetBookingDetailsByIdApiResultState
    extends BookingDetailsState {
  final BookingDetailsModel bookingDetails;

  const BookingDetailsGetBookingDetailsByIdApiResultState(
      {required this.bookingDetails});
}

final class BookingDetailsErrorState extends BookingDetailsState {
  final String errorMessage;

  const BookingDetailsErrorState(this.errorMessage);

  @override
  List<Object> get props => [];
}

final class BookingDetailsErrorApiResultState extends BookingDetailsState {
  final ErrorResponse errorResponse;

  const BookingDetailsErrorApiResultState(this.errorResponse);

  @override
  List<Object> get props => [];
}

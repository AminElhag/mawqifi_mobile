part of 'booking_cubit.dart';

sealed class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

final class BookingInitial extends BookingState {}

final class BookingHUDState extends BookingState {}

final class BookingGetProfileVehicleApiResultState extends BookingState {
  final List<VehicleModel> vehicles;

  const BookingGetProfileVehicleApiResultState({required this.vehicles});
}

final class BookingSubmitApiResultState extends BookingState {}

final class BookingErrorState extends BookingState {
  final String errorMessage;

  const BookingErrorState(this.errorMessage);

  @override
  List<Object> get props => [];
}

final class BookingErrorApiResultState extends BookingState {
  final ErrorResponse errorResponse;

  const BookingErrorApiResultState(this.errorResponse);

  @override
  List<Object> get props => [];
}

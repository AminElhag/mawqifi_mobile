part of 'parking_details_cubit.dart';

@immutable
sealed class ParkingDetailsState extends Equatable {
  const ParkingDetailsState();

  @override
  List<Object> get props => [];
}

final class ParkingDetailsInitial extends ParkingDetailsState {}

final class ParkingDetailsHUDState extends ParkingDetailsState {}

final class ParkingDetailsApiResultState extends ParkingDetailsState {
  const ParkingDetailsApiResultState({required this.parkingDetailsModel});

  final ParkingDetailsModel parkingDetailsModel;

  @override
  List<Object> get props => [];
}

final class ParkingDetailsErrorState extends ParkingDetailsState {
  final String errorMessage;

  const ParkingDetailsErrorState(this.errorMessage);

  @override
  List<Object> get props => [];
}

final class ParkingDetailsErrorApiResultState extends ParkingDetailsState {
  final ErrorResponse errorResponse;

  const ParkingDetailsErrorApiResultState(this.errorResponse);

  @override
  List<Object> get props => [];
}


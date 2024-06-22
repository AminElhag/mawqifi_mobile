part of 'parking_cubit.dart';

@immutable
sealed class ParkingState extends Equatable {
  const ParkingState();

  @override
  List<Object> get props => [];
}

final class ParkingInitial extends ParkingState {}

final class ParkingHUDState extends ParkingState {}

final class ParkingGetNearbyParkingApiResultState extends ParkingState {
  const ParkingGetNearbyParkingApiResultState({required this.nearbyParkingModel});

  final List<NearbyParkingModel> nearbyParkingModel;

  @override
  List<Object> get props => [];
}

final class ParkingGetParkingByNameApiResultState extends ParkingState {
  const ParkingGetParkingByNameApiResultState({required this.nearbyParkingModel});

  final List<NearbyParkingModel> nearbyParkingModel;

  @override
  List<Object> get props => [];
}

final class ParkingErrorState extends ParkingState {
  final String errorMessage;

  const ParkingErrorState(this.errorMessage);

  @override
  List<Object> get props => [];
}

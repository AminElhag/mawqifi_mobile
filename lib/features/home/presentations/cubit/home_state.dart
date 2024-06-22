part of 'home_cubit.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeHUDState extends HomeState {}

final class HomeGetNearbyParkingApiResultState extends HomeState {
  const HomeGetNearbyParkingApiResultState({required this.nearbyParkingModel});

  final List<NearbyParkingModel> nearbyParkingModel;

  @override
  List<Object> get props => [];
}

final class HomeGetParkingByNameApiResultState extends HomeState {
  const HomeGetParkingByNameApiResultState({required this.nearbyParkingModel});

  final List<NearbyParkingModel> nearbyParkingModel;

  @override
  List<Object> get props => [];
}

final class HomeErrorState extends HomeState {
  final String errorMessage;

  const HomeErrorState(this.errorMessage);

  @override
  List<Object> get props => [];
}

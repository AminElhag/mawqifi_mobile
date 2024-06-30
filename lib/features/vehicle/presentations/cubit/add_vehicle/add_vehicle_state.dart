part of 'add_vehicle_cubit.dart';

sealed class AddVehicleState extends Equatable {
  const AddVehicleState();

  @override
  List<Object> get props => [];
}

final class AddVehicleInitial extends AddVehicleState {}

final class AddVehicleHUDState extends AddVehicleState {}

final class AddVehicleApiResultState extends AddVehicleState {}

final class AddVehicleErrorState extends AddVehicleState {
  final String errorMessage;

  const AddVehicleErrorState(this.errorMessage);

  @override
  List<Object> get props => [];
}


final class AddVehicleErrorApiResultState extends AddVehicleState {
  final ErrorResponse errorResponse;

  const AddVehicleErrorApiResultState(this.errorResponse);

  @override
  List<Object> get props => [];
}

part of 'vehicle_list_cubit.dart';

@immutable
sealed class VehicleListState extends Equatable {
  const VehicleListState();

  @override
  List<Object> get props => [];
}

final class VehicleListInitial extends VehicleListState {}

final class VehicleListHUDState extends VehicleListState {}

final class VehicleListApiResultState extends VehicleListState {
  final List<VehicleModel> items;

  const VehicleListApiResultState({required this.items});
}

final class VehicleListErrorState extends VehicleListState {
  final String errorMessage;

  const VehicleListErrorState(this.errorMessage);

  @override
  List<Object> get props => [];
}

final class VehicleListErrorApiResultState extends VehicleListState {
  final ErrorResponse errorResponse;

  const VehicleListErrorApiResultState(this.errorResponse);

  @override
  List<Object> get props => [];
}

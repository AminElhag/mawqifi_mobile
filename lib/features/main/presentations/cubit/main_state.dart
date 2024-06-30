part of 'main_cubit.dart';

sealed class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

final class MainInitial extends MainState {}

final class MainHUDState extends MainInitial {}

final class MainHasNewNotificationsApiResultState extends MainInitial {
  MainHasNewNotificationsApiResultState({required this.hasNewNotifications});

  final bool hasNewNotifications;

  @override
  List<Object> get props => [];
}

final class MainErrorState extends MainInitial {
  final String errorMessage;

  MainErrorState({required this.errorMessage});

  @override
  List<Object> get props => [];
}

final class MainErrorApiResultState extends MainInitial {
  final ErrorResponse errorResponse;

  MainErrorApiResultState(this.errorResponse);

  @override
  List<Object> get props => [];
}

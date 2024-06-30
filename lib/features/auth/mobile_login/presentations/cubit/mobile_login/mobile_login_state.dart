part of 'mobile_login_cubit.dart';

@immutable
sealed class MobileLoginState extends Equatable{
  const MobileLoginState();

  @override
  List<Object> get props => [];
}

final class MobileLoginInitial extends MobileLoginState {}

final class MobileLoginHUDState extends MobileLoginState {}

final class MobileLoginApiResultState extends MobileLoginState {}

final class MobileLoginErrorState extends MobileLoginState {
  final String errorMessage;

  const MobileLoginErrorState(this.errorMessage);

  @override
  List<Object> get props => [];
}

final class MobileLoginErrorApiResultState extends MobileLoginState {
  final ErrorResponse errorResponse;

  const MobileLoginErrorApiResultState(this.errorResponse);

  @override
  List<Object> get props => [];
}

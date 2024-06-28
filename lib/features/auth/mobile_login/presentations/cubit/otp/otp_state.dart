part of 'otp_cubit.dart';

@immutable
sealed class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

final class OtpInitial extends OtpState {}

final class OtpHUDState extends OtpState {}

final class OtpWithoutProfileApiResultState extends OtpState {}

final class OtpWithProfileApiResultState extends OtpState {
  final OtpVerificationModel otpVerificationModel;

  const OtpWithProfileApiResultState({required this.otpVerificationModel});

  @override
  List<Object> get props => [];
}

final class ResendOtpApiResultState extends OtpState {}

final class OtpErrorState extends OtpState {
  final String errorMessage;

  const OtpErrorState(this.errorMessage);

  @override
  List<Object> get props => [];
}

final class OtpErrorApiResultState extends OtpState {
  final ErrorResponse errorResponse;

  const OtpErrorApiResultState(this.errorResponse);

  @override
  List<Object> get props => [];
}

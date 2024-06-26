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
  final ProfileModel? profileModel;

  const OtpWithProfileApiResultState({required this.profileModel});

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

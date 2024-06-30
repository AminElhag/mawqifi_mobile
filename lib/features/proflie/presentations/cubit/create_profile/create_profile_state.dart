part of 'create_profile_cubit.dart';

@immutable
sealed class CreateProfileState extends Equatable {
  const CreateProfileState();

  @override
  List<Object> get props => [];
}

final class CreateProfileInitial extends CreateProfileState {}

final class CreateProfileHUDState extends CreateProfileState {}

final class CreateProfileApiResultState extends CreateProfileState {
  final ProfileModel profileModel;

  const CreateProfileApiResultState(this.profileModel);

  @override
  List<Object> get props => [];
}

final class CreateProfileErrorState extends CreateProfileState {
  final String errorMessage;

  const CreateProfileErrorState(this.errorMessage);

  @override
  List<Object> get props => [];
}

final class CreateProfileErrorApiResultState extends CreateProfileState {
  final ErrorResponse errorResponse;

  const CreateProfileErrorApiResultState(this.errorResponse);

  @override
  List<Object> get props => [];
}

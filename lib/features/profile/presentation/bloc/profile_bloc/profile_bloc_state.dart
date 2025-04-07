import 'package:serve_mate/features/profile/domain/entities/user_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {
  final UserEntity? user;
  ProfileInitial({this.user});
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;

  ProfileLoaded(this.user);
}

class ProfileSuccess extends ProfileState {
  final String message;

  ProfileSuccess(this.message);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}



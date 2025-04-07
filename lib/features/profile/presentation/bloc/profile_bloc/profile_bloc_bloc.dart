import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/profile/domain/entities/user_entity.dart';
import 'package:serve_mate/features/profile/domain/usecase/get_user_details.dart';
import 'package:serve_mate/features/profile/presentation/bloc/profile_bloc/profile_bloc_event.dart';
import 'package:serve_mate/features/profile/presentation/bloc/profile_bloc/profile_bloc_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserDetails getUserDetails;

  ProfileBloc(this.getUserDetails)
      : super(ProfileInitial(user: UserEntity.empty())) {
    on<FetchUserDetails>(_onFetchUserDetails);
    on<UpdateProfileImage>(_onUpdateUser);
  }

  Future<void> _onFetchUserDetails(
      FetchUserDetails event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final user = await getUserDetails(event.userId);
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdateUser(
      UpdateProfileImage event, Emitter<ProfileState> emit) async {
    final type = UserEntity();
    emit(ProfileLoading());
    try {
      final data = type.copyWith(
        profileImageUrl: type.profileImageUrl,
      );
      getUserDetails.update(data);
      emit(ProfileSuccess('Profile updated successfully'));
    } catch (e) {
      emit(ProfileError('Failed to update user: $e'));
    }
  }
}

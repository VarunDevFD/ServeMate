
import 'package:serve_mate/features/profile/domain/entities/user_entity.dart';

abstract class ProfileEvent {}

class FetchUserDetails extends ProfileEvent {
  final String userId;

  FetchUserDetails(this.userId);
}

class UpdateProfileImage extends ProfileEvent {
  final UserEntity data;

  UpdateProfileImage(this.data);
}

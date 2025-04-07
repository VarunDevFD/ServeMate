import 'package:serve_mate/features/profile/domain/entities/user_entity.dart';
import 'package:serve_mate/features/profile/domain/repositories/profile_repository.dart';

class GetUserDetails {
  final ProfileRepository repository;

  GetUserDetails(this.repository);

  void update(UserEntity data) async {
    return await repository.updateUser(data);
  }

  Future<UserEntity> call(String userId) async {
    return await repository.getUserDetails(userId);
  }
}

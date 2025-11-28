import 'package:serve_mate/features/profile/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<void> updateUser(UserEntity user);
  Future<UserEntity> getUserDetails(String userId);
  Future<List<String>> getCategoryList(String userId);
}

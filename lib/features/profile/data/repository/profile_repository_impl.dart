 
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/profile/data/data_source/profile_remote_datasource.dart';
import 'package:serve_mate/features/profile/data/model/user_model.dart';
import 'package:serve_mate/features/profile/domain/entities/user_entity.dart';
import 'package:serve_mate/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final  remoteDataSource = serviceLocator<ProfileRemoteDataSource>(); 

  @override
  Future<void> updateUser(UserEntity user) {
    final userModel = UserModel(
      id: user.id!,
      name: user.name!,
      email: user.email!,
      profileImageUrl: user.profileImageUrl,
    );
    return remoteDataSource.updateUser(userModel);
  }



  @override
  Future<UserEntity> getUserDetails(String userId) async {
    try {
      final userModel = await remoteDataSource.getUserDetails(userId);
      return UserEntity(
        id: userModel.id,
        name: userModel.name,
        email: userModel.email,
        password: userModel.password,
        phone: userModel.phone,
        location: userModel.location,
        profileImageUrl: userModel.profileImageUrl,
      );
    } catch (e) {
      rethrow;
    }
  }
}
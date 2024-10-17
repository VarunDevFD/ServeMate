import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/repositories/auth_repo_impl.dart';
import '../../features/auth/domain/repositories/auth_repo.dart';
import '../../features/auth/domain/usecases/auth_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';

final serviceProvider = GetIt.instance;

Future<void> init() async {
  //-----------------------Auth-------------------------------------------------
  // Firebase
  serviceProvider.registerLazySingleton(() => FirebaseAuth.instance);

  // Repositories
  serviceProvider.registerLazySingleton<AuthRepository>(
      () => FirebaseAuthRepositoryImpl(serviceProvider()));

  // Use Cases
  serviceProvider
      .registerLazySingleton(() => SignInWithEmailPassword(serviceProvider()));
  serviceProvider.registerLazySingleton(
      () => RegisterWithEmailPassword(serviceProvider()));

  // BLoC
  serviceProvider.registerFactory(() => AuthBloc());
}

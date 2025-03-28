import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serve_mate/core/data/local/preferences_data_source.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:serve_mate/features/authentication/data/repositories/data_auth_repo.dart';
import 'package:serve_mate/features/authentication/domain/repositories/auth_repo.dart';
import 'package:serve_mate/features/authentication/domain/usecases/auth_user.dart';
import 'package:serve_mate/features/authentication/domain/usecases/sign_in_with_email_password.dart';
import 'package:serve_mate/features/authentication/domain/usecases/sign_in_with_google.dart';
import 'package:serve_mate/features/authentication/domain/usecases/sign_out.dart';
import 'package:serve_mate/features/authentication/domain/usecases/sign_up_with_email_password.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:serve_mate/features/category/data/repositories/category_repository_impl.dart';
import 'package:serve_mate/features/category/domain/repositories/category_repository.dart';
import 'package:serve_mate/features/category/domain/usecases/get_categories.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_bloc.dart';

import 'package:serve_mate/features/on_boarding/data/repositories/on_boarding_repository_impl.dart';
import 'package:serve_mate/features/on_boarding/domain/repositories/repo_onboarding.dart';
import 'package:serve_mate/features/on_boarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:serve_mate/features/on_boarding/domain/usecases/get_on_boarding_data.dart';
import 'package:serve_mate/firebase_options.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //--------------------Initialize Firebase-------------------------------------

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //--------------------Shared-Preference---------------------------------------
  serviceLocator.registerLazySingleton<PreferencesRepository>(
      () => PreferencesRepository());

  serviceLocator.registerLazySingleton<PreferencesDataSource>(
      () => PreferencesDataSource());

  //--------------------On-Boarding-Screen--------------------------------------

  // Repository
  serviceLocator.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(),
  );

  // Use cases
  serviceLocator.registerLazySingleton(
    () => GetOnboardingPagesUseCase(serviceLocator<OnboardingRepository>()),
  );

  serviceLocator.registerLazySingleton(
    () => CompleteOnboardingUseCase(serviceLocator<OnboardingRepository>()),
  );

  //--------------------Firebase---------------------------------------
  serviceLocator
      .registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  serviceLocator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  //--------------------Auth Data Sources---------------------------------------
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );

  //--------------------Auth Repositories---------------------------------------
  serviceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl());

  //--------------------Auth Use Cases------------------------------------------
  serviceLocator.registerLazySingleton<SignUpWithEmailPassword>(
      () => SignUpWithEmailPassword());
  serviceLocator.registerLazySingleton<SignInWithEmailPassword>(
      () => SignInWithEmailPassword());
  serviceLocator.registerLazySingleton<SignInWithGoogle>(
      () => SignInWithGoogle());
  serviceLocator.registerLazySingleton<GetCurrentUser>(
      () => GetCurrentUser(repository: serviceLocator<AuthRepository>()));

  //--------------------Auth Bloc-----------------------------------------------
  serviceLocator
      .registerLazySingleton(() => SignOut(serviceLocator<AuthRepository>()));

  serviceLocator.registerLazySingleton(() => AuthBloc());

  // Register CategoryRepository (data source) in service locator
  serviceLocator.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(),
  );

// Register GetCategories use case
  serviceLocator.registerLazySingleton<GetCategories>(
    () => GetCategories(serviceLocator<CategoryRepository>()),
  );

  // Register the CategoryBloc with the repository
  serviceLocator.registerFactory<CategoryBloc>(
    () => CategoryBloc(),
  );
}

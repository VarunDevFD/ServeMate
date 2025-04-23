import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serve_mate/core/data/local/preferences_data_source.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:serve_mate/features/authentication/data/repositories/data_auth_repo.dart';
import 'package:serve_mate/features/authentication/domain/repositories/auth_repo.dart';
import 'package:serve_mate/features/authentication/domain/usecases/sign_in_with_email_password.dart';
import 'package:serve_mate/features/authentication/domain/usecases/sign_in_with_google.dart';
import 'package:serve_mate/features/authentication/domain/usecases/sign_up_with_email_password.dart';
import 'package:serve_mate/features/category/data/data_source/data_source_category.dart';
import 'package:serve_mate/features/category/data/repositories/category_repository_impl.dart';
import 'package:serve_mate/features/category/domain/repositories/category_repository.dart';
import 'package:serve_mate/features/category/domain/usecases/get_categorys_usecase.dart';
import 'package:serve_mate/features/category/domain/usecases/save_category.dart';
import 'package:serve_mate/features/on_boarding/data/repositories/on_boarding_repository_impl.dart';
import 'package:serve_mate/features/on_boarding/domain/repositories/repo_onboarding.dart';
import 'package:serve_mate/features/on_boarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:serve_mate/features/on_boarding/domain/usecases/get_on_boarding_data.dart';
import 'package:serve_mate/features/product/data/datasource/product_datasource.dart';
import 'package:serve_mate/features/product/data/repository/product_repo.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';
import 'package:serve_mate/features/product/doamin/usecase/add_dress_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/camera_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/decoration_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/footwear_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/jewelry_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/sound_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/vehicle_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/venue_use_case.dart';
import 'package:serve_mate/features/profile/data/data_source/profile_remote_datasource.dart';
import 'package:serve_mate/features/profile/data/repository/profile_repository_impl.dart';
import 'package:serve_mate/features/profile/domain/usecase/get_user_details.dart';
import 'package:serve_mate/features/profile/presentation/bloc/profile_bloc/profile_bloc_bloc.dart';
import 'package:serve_mate/secrets/firebase_options.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //--------------------Initialize Env for Security-----------------------------------
  await dotenv.load(fileName: ".env");

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

  //--------------------Authentication---------------------------------------
  serviceLocator.registerLazySingleton<AuthDataSource>(
    () => AuthRemoteDataSource(),
  );

  // Auth Repositories
  serviceLocator
      .registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // Auth Use Cases
  serviceLocator.registerLazySingleton<SignUpWithEmailPassword>(
      () => SignUpWithEmailPassword());
  serviceLocator.registerLazySingleton<SignInWithEmailPassword>(
      () => SignInWithEmailPassword());
  serviceLocator
      .registerLazySingleton<SignInWithGoogle>(() => SignInWithGoogle());

  // Register CategoryRepository (data source) in service locator
  serviceLocator.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(),
  );

// Register GetCategories use case
  serviceLocator.registerLazySingleton<GetCategories>(
    () => GetCategories(serviceLocator<CategoryRepository>()),
  );

  //------------------Category-----------------------------------------
  serviceLocator.registerLazySingleton<DataSourceCategory>(
    () => DataSourceRemoteCategory(),
  );

  serviceLocator.registerLazySingleton<SaveCategory>(() => SaveCategory());

  //--------------------Product-------------------------------------------------

  //--------------------Data Sources--------------------
  serviceLocator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(),
  );

  //--------------------Repository--------------------
  serviceLocator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: serviceLocator<ProductRemoteDataSource>(),
    ),
  );

  // Dress Usecase
  serviceLocator.registerLazySingleton<DressUseCase>(
      () => DressUseCase(serviceLocator<ProductRepository>()));

  // Camera Usecase
  serviceLocator.registerLazySingleton<CameraUseCase>(
    () => CameraUseCase(),
  );

  // FootWear Usecase
  serviceLocator.registerLazySingleton<FootwearUseCase>(
      () => FootwearUseCase(serviceLocator<ProductRepository>()));

  // Jewelry Usecase
  serviceLocator.registerLazySingleton<JewelryUseCase>(
      () => JewelryUseCase(serviceLocator<ProductRepository>()));

  // Sound Usecase
  serviceLocator.registerLazySingleton<SoundUseCase>(
      () => SoundUseCase(serviceLocator<ProductRepository>()));

  // Venue Usecase
  serviceLocator.registerLazySingleton<VenueUseCase>(
      () => VenueUseCase(serviceLocator<ProductRepository>()));

  // Vehicle Usecase
  serviceLocator.registerLazySingleton<VehicleUseCase>(
      () => VehicleUseCase(serviceLocator<ProductRepository>()));

  // Decoration Usecase
  serviceLocator.registerLazySingleton<DecorationUseCase>(
      () => DecorationUseCase(serviceLocator<ProductRepository>()));

  //--------------------Profile Data--------------------------------------------

// DataSource
  serviceLocator.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(),
  );

// Repository
  serviceLocator.registerLazySingleton<ProfileRepositoryImpl>(
    () => ProfileRepositoryImpl(),
  );

// UseCase
  serviceLocator.registerLazySingleton<GetUserDetails>(
    () => GetUserDetails(serviceLocator<ProfileRepositoryImpl>()),
  );

// Bloc
  serviceLocator
      .registerFactory(() => ProfileBloc(serviceLocator<GetUserDetails>()));
}

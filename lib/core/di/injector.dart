import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serve_mate/features/auth/data/datasources/data_auth_datasourse.dart';
import 'package:serve_mate/features/auth/data/repositories/data_auth_repo.dart';
import 'package:serve_mate/features/auth/domain/repositories/auth_repo.dart';
import 'package:serve_mate/features/auth/domain/usecases/auth_user.dart';
import 'package:serve_mate/features/auth/domain/usecases/sign_in_with_email_password.dart';
import 'package:serve_mate/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:serve_mate/features/auth/domain/usecases/sign_out.dart';
import 'package:serve_mate/features/auth/domain/usecases/sign_up_with_email_password.dart';
import 'package:serve_mate/features/auth/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:serve_mate/firebase_options.dart';
final serviceLocator = GetIt.instance;

Future<void> init() async {
  //--------------------Connect-with-firebase_options.dart----------------------
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //--------------------Auth-Firebase-dependencies------------------------------
  serviceLocator
      .registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  //--------------------Auth Data Sources---------------------------------------
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(
      firebaseAuth: serviceLocator<FirebaseAuth>(),
      googleSignIn: serviceLocator<GoogleSignIn>(),
    ),
  );

  //--------------------Auth Repositories---------------------------------------
  serviceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator<AuthRemoteDataSource>()));

  //--------------------Auth Use Cases------------------------------------------
  serviceLocator.registerLazySingleton<SignUpWithEmailPassword>(
      () => SignUpWithEmailPassword(serviceLocator<AuthRepository>()));
  serviceLocator.registerLazySingleton<SignInWithEmailPassword>(
      () => SignInWithEmailPassword(serviceLocator<AuthRepository>()));
  serviceLocator.registerLazySingleton<SignInWithGoogle>(
      () => SignInWithGoogle(serviceLocator<AuthRepository>()));
  serviceLocator.registerLazySingleton<GetCurrentUser>(
      () => GetCurrentUser(repository: serviceLocator<AuthRepository>()));

  //--------------------Auth Bloc-----------------------------------------------
  serviceLocator
      .registerLazySingleton(() => SignOut(serviceLocator<AuthRepository>()));

  serviceLocator.registerLazySingleton(() => AuthBloc(
      googleSignIn: serviceLocator<SignInWithGoogle>(),
      googleSignOut: serviceLocator<SignOut>()));
}

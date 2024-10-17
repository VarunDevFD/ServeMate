import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/error/failure.dart';
import 'package:serve_mate/features/auth/domain/repositories/auth_repo.dart';

class SignOut {
  final AuthRepository repository;

  SignOut(this.repository);

   
  Future<Either<Failure, void>>  call() async {
    return await repository.signOut(); // Call the sign-out method from the repository
  }
}

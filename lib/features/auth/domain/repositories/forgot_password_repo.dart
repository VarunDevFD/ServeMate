
import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/error/failure.dart';

abstract interface class ForgetPasswordRepo {
 Future<Either<Failure, void>> resetPassword({required String email});}

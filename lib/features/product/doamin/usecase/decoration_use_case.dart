import 'package:dartz/dartz.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/product/doamin/entities/decoration.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class DecorationUseCase {
  final repository = serviceLocator<ProductRepository>();

  Future<Either<String, String>> execute(DecorationEntity decoration) async {
    return await repository.addDecorationEntity(decoration);
  }
}

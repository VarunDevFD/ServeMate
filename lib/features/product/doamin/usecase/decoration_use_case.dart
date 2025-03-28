import 'package:serve_mate/features/product/doamin/entities/decoration.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class DecorationUseCase {
  final ProductRepository repository;

  DecorationUseCase(this.repository);

  Future<void> execute(Decoration decorationEntity) async {
    return await repository.addDecoration(decorationEntity);
  }

  Future<List<Decoration>> fetchDecorations() async {
    return await repository.fetchDecorations();
  }
}

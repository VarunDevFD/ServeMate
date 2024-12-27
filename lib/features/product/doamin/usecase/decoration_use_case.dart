import 'package:serve_mate/features/product/doamin/entities/decoration_entity.dart';
import 'package:serve_mate/features/product/doamin/repository/domain_repository.dart';

class AddDecorationUseCase {
  final ProductRepository repository;

  AddDecorationUseCase(this.repository);

  Future<void> execute(DecorationEntity decorationEntity) async {
    return await repository.addDecoration(decorationEntity);
  }
}

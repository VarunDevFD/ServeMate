import 'package:bloc/bloc.dart';
import 'package:serve_mate/features/product/data/models/dress_model.dart';
import 'package:serve_mate/features/product/doamin/usecase/domain_product_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductProductUsecase productProductUsecase;
  ProductBloc({required this.productProductUsecase}) : super(ProductInitial()) {
    on<ProductLoadedEvent>(productReg);
  }
  Future<void> productReg(
      ProductLoadedEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final dress = await productProductUsecase.getDomainCategory();
    emit(ProductLoaded(dress));
  }
}

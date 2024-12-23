import 'package:bloc/bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    final pref = serviceLocator<PreferencesRepository>();

    // Emit last saved category on initialization
    _initializeCategory(pref);

    // Handle CategoryNameEvent
    on<CategoryNameEvent>((event, emit) async {
      emit(ProductInitial());

      try {
        String? response = await pref.getDataFn();
        emit(ProductLoaded(categoryName: response));
      } catch (e) {
        emit(ProductError("Find Error: $e"));
      }
    });
  }

  Future<void> _initializeCategory(PreferencesRepository pref) async {
    try {
      final savedCategory = await pref.getDataFn();
      if (savedCategory != null) {
        add(CategoryNameEvent(savedCategory)); // Pass the saved category
      }
    } catch (e) {
      emit(ProductError("Initialization Error: $e"));
    }
  }
}

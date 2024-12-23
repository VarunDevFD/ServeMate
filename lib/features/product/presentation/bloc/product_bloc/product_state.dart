part of 'product_bloc.dart';

sealed class ProductState {
  const ProductState();
}

final class ProductInitial extends ProductState {}

final class ProductLoaded extends ProductState {
  final String? categoryName;

  ProductLoaded({this.categoryName});
}

final class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

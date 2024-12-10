part of 'product_bloc.dart';

sealed class ProductState {
  const ProductState();
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final DressModel model;

  ProductLoaded(this.model);
}

final class ProductError extends ProductState {
  final String error;
  ProductError(this.error);
}

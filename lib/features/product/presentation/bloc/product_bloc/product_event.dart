part of 'product_bloc.dart';

abstract class ProductEvent {}

class ProductLoadedEvent extends ProductEvent {
  final DressModel model;
  ProductLoadedEvent(this.model);
}

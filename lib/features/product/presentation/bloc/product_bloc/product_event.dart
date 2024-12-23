part of 'product_bloc.dart';

abstract class ProductEvent {}

class CategoryNameEvent extends ProductEvent {
  final String name;
  CategoryNameEvent(this.name);
}

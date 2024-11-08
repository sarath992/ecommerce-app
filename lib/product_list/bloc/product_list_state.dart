// product_list_state.dart

import 'package:ecomm_app/product_list/model/model.dart';

abstract class ProductListState {}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<Product> products;

  ProductListLoaded({required this.products});
}

class ProductListError extends ProductListState {
  final String message;

  ProductListError({required this.message});
}

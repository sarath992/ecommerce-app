
import 'package:ecomm_app/product_list/bloc/product_list_event.dart';
import 'package:ecomm_app/product_list/bloc/product_list_state.dart';
import 'package:ecomm_app/product_list/repository/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductRepository productRepository;

  ProductListBloc({required this.productRepository}) : super(ProductListInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductListState> emit) async {
    emit(ProductListLoading()); 

    try {
      final products = await productRepository.fetchProducts();  
      emit(ProductListLoaded(products: products)); 
    } catch (e) {
      emit(ProductListError(message: e.toString())); 
    }
  }
}

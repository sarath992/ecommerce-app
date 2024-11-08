import 'package:ecomm_app/product_details/bloc/product_details_event.dart';
import 'package:ecomm_app/product_details/bloc/product_details_state.dart';
import 'package:ecomm_app/product_details/repository/details_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ProductService productService;

  ProductDetailsBloc(this.productService) : super(ProductDetailsInitial()) {
    on<LoadProductDetails>(_onLoadProductDetails);
  }

  Future<void> _onLoadProductDetails(
      LoadProductDetails event, Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsLoading());
    try {
      final product = await productService.fetchProductDetails(event.productId);
      emit(ProductDetailsLoaded(product: product));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }
}

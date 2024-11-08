import 'package:ecomm_app/addtocart/bloc/add_to_cart_bloc.dart';
import 'package:ecomm_app/addtocart/bloc/add_to_cart_event.dart';
import 'package:ecomm_app/addtocart/bloc/add_to_cart_state.dart';
import 'package:ecomm_app/addtocart/model/add_model.dart';
import 'package:ecomm_app/addtocart/repository/add_to_cart_repo.dart';
import 'package:ecomm_app/gotocart/ui/view_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddToCartScreen extends StatelessWidget {
  final int productId;
  final FlutterSecureStorage storage = FlutterSecureStorage();
  AddToCartScreen({required this.productId});
  Future<String?> getToken() async {
  return await storage.read(key: 'auth_token');
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add to Cart'),
      ),
      body: BlocProvider(
        create: (context) => AddToCartBloc(
          repository: AddToCartRepository(storage: FlutterSecureStorage()),
        ),
        child: BlocConsumer<AddToCartBloc, AddToCartState>(
          listener: (context, state) {
            if (state is AddToCartSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is AddToCartFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            if (state is AddToCartLoading) {
              return Center(child: CircularProgressIndicator());
            }
             final token =  getToken(); 
            return Center(
              
              child: ElevatedButton(
                onPressed: () {
                  final request = AddToCartRequest(
                    productId: productId,
                    quantity: 1, // You can customize the quantity
                  );
                  context.read<AddToCartBloc>().add(AddToCartRequested(request: request));
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartScreen(token: token.toString())),
                            );
                },
                child: Text('Go to cart'),
                        ),
            );
          },
              ),
            ),
        
    );
  }
}

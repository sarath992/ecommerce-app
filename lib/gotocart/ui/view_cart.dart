import 'package:ecomm_app/gotocart/bloc/view_cart_bloc.dart';
import 'package:ecomm_app/gotocart/bloc/view_cart_event.dart';
import 'package:ecomm_app/gotocart/bloc/view_cart_state.dart';
import 'package:ecomm_app/gotocart/repository/view_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  final String token;

  CartScreen({required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Cart'),
      ),
      body: BlocProvider(
        create: (context) => CartBloc(cartRepository: CartRepository())
          ..add(FetchCartItems(token: token)),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is CartError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            if (state is CartLoaded) {
              final cartItems = state.cartItems;

              if (cartItems.isEmpty) {
                return Center(child: Text('Your cart is empty.'));
              }

              return ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    leading: Image.network(item.image), 
                    title: Text(item.productName),
                    subtitle: Text('Quantity: ${item.quantity}'),
                    trailing: Text('\$${item.price.toStringAsFixed(2)}'),
                  );
                },
              );
            }

            return Container(); 
          },
        ),
      ),
    );
  }
}

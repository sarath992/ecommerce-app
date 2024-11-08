import 'package:ecomm_app/addtocart/ui/add.dart';
import 'package:ecomm_app/checkout/ui/buy.dart';
import 'package:ecomm_app/product_details/bloc/product_details_bloc.dart';
import 'package:ecomm_app/product_details/bloc/product_details_event.dart';
import 'package:ecomm_app/product_details/bloc/product_details_state.dart';
import 'package:ecomm_app/product_details/repository/details_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: BlocProvider(
        create: (context) => ProductDetailsBloc(ProductService())..add(LoadProductDetails(productId: productId)),
        child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailsLoaded) {
              final product = state.product;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Price: \$${product.price}',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Description: ${product.description}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Created at: ${product.createdAt}',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                   const Spacer(),
                   Row(
                      children: [
                        Expanded(child: ElevatedButton(onPressed: (){
                             Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddToCartScreen(productId: product.id,
                            ),
                          ),
                        );
                             ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Added to cart')),
                              );

                        }, child: Text('Add to Cart'))),

                         SizedBox(width: 10),
                         Expanded(child: ElevatedButton(onPressed: (){
                           Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutScreen()
                          ),
                        );
                             ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Order Placed')),
                              );
                         }, child: Text('Buy Now')))
                      ],
                   )

                  ],
                ),
              );
            } else if (state is ProductDetailsError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('Something went wrong!'));
            }
          },
        ),
      ),
    );
  }
}

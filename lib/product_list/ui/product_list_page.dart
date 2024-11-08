// product_list_page.dart
import 'package:ecomm_app/product_details/ui/product_details_ui.dart';
import 'package:ecomm_app/product_list/bloc/product_list_bloc.dart';
import 'package:ecomm_app/product_list/bloc/product_list_event.dart';
import 'package:ecomm_app/product_list/bloc/product_list_state.dart';
import 'package:ecomm_app/product_list/repository/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductListBloc(productRepository: ProductRepository())..add(FetchProducts()),  
      child: Scaffold(
        appBar: AppBar(title: Text('Product List')),
        body: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListLoading) {
              return Center(child: CircularProgressIndicator());  
            } else if (state is ProductListError) {
              return Center(child: Text('Error: ${state.message}')); 
            } else if (state is ProductListLoaded) {
              final products = state.products;  
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];  
                  return Card(
                    child: ListTile(
                      leading: product.image != null && product.image!.isNotEmpty
                          ? Image.network(
                              'https://globosoft.co.uk/ecommerce-api/${product.image}',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : SizedBox.shrink(),
                      title: Text(product.name),  
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.description),  
                          Text('Price: \$${product.price}'), 
                        ],
                      ),
                      onTap: () {
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                              productId: product.id, 
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No products found.'));
            }
          },
        ),
      ),
    );
  }
}

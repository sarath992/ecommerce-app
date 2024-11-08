import 'package:ecomm_app/checkout/bloc/checkout_bloc.dart';
import 'package:ecomm_app/checkout/bloc/checkout_event.dart';
import 'package:ecomm_app/checkout/bloc/checkout_state.dart';
import 'package:ecomm_app/checkout/model/buy_model.dart';
import 'package:ecomm_app/checkout/repository/buy_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CheckoutScreen extends StatelessWidget {
  final _addressController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutBloc(
        checkoutRepository: RepositoryProvider.of<CheckoutRepository>(context),
      ),
      child: Scaffold(
        appBar: AppBar(title: Text('Checkout')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: _latitudeController,
                decoration: InputDecoration(labelText: 'Latitude'),
              ),
              TextField(
                controller: _longitudeController,
                decoration: InputDecoration(labelText: 'Longitude'),
              ),
              SizedBox(height: 20),
              BlocConsumer<CheckoutBloc, CheckoutState>(
                listener: (context, state) {
                  if (state is CheckoutSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                    Navigator.pop(context); // Go back after success
                  } else if (state is CheckoutFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CheckoutLoading) {
                    return CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      final token = 'YourAuthTokenHere'; // Replace with actual token retrieval logic
                      final request = CheckoutRequest(
                        address: _addressController.text,
                        latitude: _latitudeController.text,
                        longitude: _longitudeController.text,
                      );
                      context.read<CheckoutBloc>().add(StartCheckout(token, request));
                    },
                    child: Text('Buy Now'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

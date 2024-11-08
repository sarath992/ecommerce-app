// models/checkout_request.dart
class CheckoutRequest {
  final String address;
  final String latitude;
  final String longitude;

  CheckoutRequest({required this.address, required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() => {
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
      };
}

// models/checkout_response.dart
class CheckoutResponse {
  final String message;
  final int? orderId;

  CheckoutResponse({required this.message, this.orderId});

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutResponse(
      message: json['message'],
      orderId: json['order_id'],
    );
  }
}

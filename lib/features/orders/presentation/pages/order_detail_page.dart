import 'package:flutter/material.dart';
class OrderDetailPage extends StatelessWidget {
  final int orderId;
  const OrderDetailPage({super.key, required this.orderId});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('جزئیات سفارش')),
    body: Center(child: Text('Order: $orderId')),
  );
}

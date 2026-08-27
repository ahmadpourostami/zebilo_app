import 'package:flutter/material.dart';
class ProductDetailPage extends StatelessWidget {
  final int productId;
  const ProductDetailPage({super.key, required this.productId});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('محصول')),
    body: Center(child: Text('Product: $productId')),
  );
}

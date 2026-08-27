import 'package:flutter/material.dart';
class CategoryProductsPage extends StatelessWidget {
  final int categoryId;
  final String categoryName;
  const CategoryProductsPage({super.key, required this.categoryId, required this.categoryName});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(categoryName)),
    body: Center(child: Text('Category: $categoryId')),
  );
}

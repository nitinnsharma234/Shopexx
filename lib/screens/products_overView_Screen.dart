import 'package:flutter/material.dart';
import 'package:shopexx/widgets/product_item.dart';

import '../model/products.dart';
import '../widgets/ProductsGrid.dart';

class ProductOverviewScreen extends StatelessWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
      ),
      body: ProductsGrid(),
    );
  }
}



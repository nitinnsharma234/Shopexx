import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shopexx/widgets/product_item.dart';

import '../Providers/products.dart';
import '../model/products.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData =Provider.of<Products>(context);
    final loadedProducts =productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2),
      itemBuilder: (context, index) {
        return ProductItem(loadedProducts[index].id, loadedProducts[index].title, loadedProducts[index].imageUrl);
      },
      itemCount: loadedProducts.length,
    );
  }
}
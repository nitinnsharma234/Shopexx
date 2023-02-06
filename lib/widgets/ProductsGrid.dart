import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shopexx/widgets/product_item.dart';

import '../Providers/products.dart';
import '../model/product.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFav;
  const ProductsGrid(this.showOnlyFav,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final loadedProducts = showOnlyFav?productData.favouriteItems:productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
            value:loadedProducts[index],
        child: const ProductItem());
      },
      itemCount: loadedProducts.length,
    );
  }
}
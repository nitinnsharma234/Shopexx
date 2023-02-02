import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopexx/screens/product_detail_screen.dart';

import '../model/product.dart';

class ProductItem extends StatelessWidget {

  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product=Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(footer: GridTileBar(
        title: Text(product.title),
        backgroundColor: Colors.black87,
        leading: IconButton(onPressed:(){product.toggleFavourite();},icon: Icon(product.isFavourite?Icons.favorite:Icons.favorite_border,color: Theme.of(context).colorScheme.secondary,)),
        trailing: IconButton(icon:Icon(Icons.shopping_cart,color: Theme.of(context).colorScheme.secondary,), onPressed: () {  },),
      ),child: GestureDetector(onTap:(){
          Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: product.id);
      },child: Image.network(product.imageUrl,fit: BoxFit.cover,)),),
    );
  }
}

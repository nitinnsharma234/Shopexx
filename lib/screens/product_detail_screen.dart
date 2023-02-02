import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/products.dart';

import '../model/products.dart';
class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId =ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context,listen:false).items.firstWhere((prod) => prod.id==productId );
    return Scaffold(
      appBar: AppBar(title:  Text(loadedProduct.title),),
    );
  }
}

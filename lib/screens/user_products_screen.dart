import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopexx/widgets/user_product_item.dart';

import '../Providers/products.dart';
import '../widgets/appDrawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user_products';

  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Your Products"),
        actions: const [IconButton(onPressed: null, icon: Icon(Icons.add),),],),
      drawer: AppDrawer(),
      body:  Padding(
        padding: const EdgeInsets.all(8),
        child:ListView.builder(itemBuilder: (_,i){
          return Column(
            children: [
              UserProductItem(title: productsData.items[i].title, imageUrl: productsData.items[i].imageUrl),
              const Divider(),
            ],
          );
        },itemCount: productsData.items.length,)
      ),
    );
  }
}

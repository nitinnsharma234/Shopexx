import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopexx/screens/edit_product_screen.dart';
import 'package:shopexx/widgets/user_product_item.dart';

import '../Providers/products.dart';
import '../widgets/appDrawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user_products';


  Future<void> _refreshProducts  (BuildContext context)
  async {
    return await Provider.of<Products>(context,listen:false).fetchAndSetProducts();
  }

  const  UserProductsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Your Products"),
        actions:  [IconButton(onPressed: (){Navigator.of(context).pushNamed(EditProductScreen.routeName);}, icon: const Icon(Icons.add),),],),
      drawer: const AppDrawer(),
      body:  RefreshIndicator(
        displacement: 20,
        onRefresh: (){
          return _refreshProducts(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child:ListView.builder(itemBuilder: (_,i){
            return Column(
              children: [
                UserProductItem(title: productsData.items[i].title, imageUrl: productsData.items[i].imageUrl,id:productsData.items[i].id),
                const Divider(),
              ],
            );
          },itemCount: productsData.items.length,)
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopexx/screens/cartScreens.dart';
import 'package:shopexx/widgets/appDrawer.dart';
import 'package:shopexx/widgets/badge.dart';

import '../Providers/cart.dart';
import '../Providers/products.dart';
import '../model/product.dart';
import '../widgets/ProductsGrid.dart';

enum filterOptions{
  Favourites,
  All
}
class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var  _showOnlyFav =false;
  var _isInit=true;
  var _isLoading=false;
  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
    if(_isInit)
      {
        setState(() {
          _isLoading=true;
        });
        Provider.of<Products>(context).fetchAndSetProducts().then((value) {
          setState(() {
            _isLoading=false;
          });
        });
      }
      _isInit=false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: [
          Consumer<Cart>(builder:(_,cart,ch)=>Badge(value:cart.itemCount.toString() , child: ch!,),
          child:  IconButton(icon: const Icon(Icons.shopping_cart),onPressed: (){
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },),),
          PopupMenuButton(onSelected:(selectedValue){
           setState(() {
             if (selectedValue == filterOptions.Favourites)
             {
               _showOnlyFav=true;
             }
             else{
               _showOnlyFav=false;
             }
           });
          },icon:const Icon(Icons.more_vert),itemBuilder: (context) => [const PopupMenuItem(value: filterOptions.Favourites,child: Text("Only Favourites"),),
            const PopupMenuItem(value: filterOptions.All,child: Text("All"),)]
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading?const Center(child: CircularProgressIndicator()): ProductsGrid(_showOnlyFav),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/cart.dart';
import '../Providers/orders.dart';
import '../widgets/cart_item.dart' as ci;

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = "/CartScreen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(appBar: AppBar(title: const Text('Your Cart'),),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(padding: const EdgeInsets.all(8),
                child: Row(
                  children: [const Text("Total",
                  style: TextStyle(fontSize: 20),),
                const Spacer(),
                Chip(label: Text("\$${cart.totalAmount.toStringAsFixed(2)}",
                  style: const TextStyle(color: Colors.white),),
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .primary,),TextButton(onPressed: ()
            {
              Provider.of<Orders>(context,listen: false).addOrder(cart.items.values.toList(), cart.totalAmount);
              cart.clear();
            },
            child: const Text(
                'Order Now', style: TextStyle(color: Colors.purple,)),)
        ],),),)
    ,const SizedBox(height: 10,),
      Expanded(child: ListView.builder(itemBuilder: (_,idx){
       return ci. CartItem(
          cart.items.values.toList()[idx].id,
          cart.items.values.toList()[idx].price,
          cart.items.values.toList()[idx].quantity,
          cart.items.values.toList()[idx].title,
          cart.items.keys.toList()[idx]
        );
      },itemCount: cart.itemCount,))
    ]
    ,
    )
    ,
    );
  }
}

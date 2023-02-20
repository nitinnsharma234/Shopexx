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
                      .primary,),OrderButton(cart: cart)
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading= false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
    onPressed:(widget.cart.totalAmount<=0 || _isLoading)?null:  ()async
            {
              setState(() {
                _isLoading=true;
              });
              await Provider.of<Orders>(context,listen: false).addOrder(widget.cart.items.values.toList(), widget.cart.totalAmount);
              setState(() {
                _isLoading=false;
              });
              widget.cart.clear();
            },
            child: _isLoading?const CircularProgressIndicator():const Text(
                'Order Now', style: TextStyle(color: Colors.purple,)),);
  }
}

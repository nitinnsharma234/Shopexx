import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopexx/widgets/OrderItemCard.dart';
import 'package:shopexx/widgets/appDrawer.dart';

import '../Providers/orders.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context,listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text("Your Orders"),),
      drawer: const AppDrawer(),
      body: ListView.builder(itemBuilder: (ctx,i){
        return OrderItemCard(order: ordersData.orders[i]);
      },itemCount: ordersData.orders.length,),
    );
  }
}

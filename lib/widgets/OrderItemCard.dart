import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Providers/orders.dart';

class OrderItemCard extends StatefulWidget {

  const OrderItemCard({Key? key, required this.order}) : super(key: key);
  final OrderItem order;

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {

  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(margin: const EdgeInsets.all(10), child: Column(
      children: [ListTile(title: Text('\$ ${widget.order.amount}'),
        subtitle: Text(
            DateFormat('dd-MM-yyyy hh:mm').format(widget.order.dateTime)),
        trailing: IconButton(
          icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
          onPressed: () {
            setState(() {
              _expanded =! _expanded;
            });
          },),),
        if(_expanded)
          Container(padding:const EdgeInsets.symmetric(vertical: 5, horizontal: 10),height: min(widget.order.products.length * 20.0 + 20, 180),
            child: ListView(children: widget.order.products.map((product) => Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                  Text(product.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text("${product.quantity} x \$${product.price}", style: const TextStyle(fontSize: 18,color: Colors.grey),)
                ],),).toList(),),)
      ],
    ),);
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem>products;
  final DateTime dateTime;

  OrderItem(
      {required this.id, required this.amount, required this.products, required this.dateTime});

}

class Orders with ChangeNotifier {
  List<OrderItem>_orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final response = await http.get(Uri.parse(
        "https://shopexx-49bc9-default-rtdb.firebaseio.com/orders/.json"));
    final  List <OrderItem> loadedOrders=[];
    var extractedData= json.decode(response.body) as Map<String, dynamic>;
    if (extractedData==null)
    {
      return ;
    }
    extractedData.forEach((orderId, orderData) {
    loadedOrders.add(
    OrderItem(
    id: orderId,
    amount: orderData["amount"],
    dateTime: DateTime.parse(orderData["dateTime"]),
    products: (orderData['products'] as List <dynamic>).map((e) =>
    CartItem(id: e["id"],
    title: e["title"],
    quantity: e["quantity"],
    price: e["price"])).toList()
    ),);
    });


    _orders= loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async
  {
    final timeStamp = DateTime.now();
    final response = await http.post(Uri.parse(
        "https://shopexx-49bc9-default-rtdb.firebaseio.com/orders/.json"),
        body: jsonEncode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts.map((cp) =>
          {
            'id': cp.id,
            'title': cp.title,
            'quantity': cp.quantity,
            'price': cp.price
          }).toList()
        }));
    _orders.insert(0, OrderItem(
        id: json.decode(response.body)['name'].toString(),
        amount: total,
        products: cartProducts,
        dateTime: timeStamp));

    notifyListeners();
  }

  void clear() {
    _orders = [];
    notifyListeners();
  }

}
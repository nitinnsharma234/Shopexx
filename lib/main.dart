import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopexx/Providers/cart.dart';
import 'package:shopexx/screens/cartScreens.dart';
import 'package:shopexx/screens/orders_screen.dart';
import 'package:shopexx/screens/product_detail_screen.dart';
import 'package:shopexx/screens/products_overView_Screen.dart';
import 'package:shopexx/screens/user_products_screen.dart';

import 'Providers/orders.dart';
import 'Providers/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders())
      ],
      /*ChangeNotifierProvider(
      create:(ctx) => Products(),*/
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange,primary: Colors.purple),
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
          CartScreen.routeName:(context) =>  const CartScreen(),
          OrderScreen.routeName:(ctx)=> const OrderScreen(),
          UserProductsScreen.routeName:(ctx) =>const UserProductsScreen(),
        },
      ),
    );
  }
}

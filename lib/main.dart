import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopexx/Providers/cart.dart';
import 'package:shopexx/screens/cartScreens.dart';
import 'package:shopexx/screens/edit_product_screen.dart';
import 'package:shopexx/screens/orders_screen.dart';
import 'package:shopexx/screens/product_detail_screen.dart';
import 'package:shopexx/screens/products_overView_Screen.dart';
import 'package:shopexx/screens/user_products_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Providers/orders.dart';

import 'Providers/products.dart';
import 'firebase_options.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken(
    vapidKey: "BMUJNv6diDvilygZWFhLVeoNI5ivEzBAbnLgdDRnsxhS0tOVvVlfJMRHYSh-OvYor1hrBElQL8i7b4peBUqSF2o",
  );
  print("Token $token");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);*/
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});



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
        home: const ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
          CartScreen.routeName:(context) =>  const CartScreen(),
          OrderScreen.routeName:(ctx)=> const OrderScreen(),
          UserProductsScreen.routeName:(ctx) =>const UserProductsScreen(),
          EditProductScreen.routeName:(ctx) => const EditProductScreen()
        },
      ),
    );
  }
}

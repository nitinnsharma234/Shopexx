import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Product  with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;
  Product(
      {required this.id, required this.title, required this.description, required this.price,required this.imageUrl, this.isFavourite=false});

  void _setFavValue(){
    isFavourite=!isFavourite;
    notifyListeners();
  }
 Future  <void> toggleFavourite()async 
  {
    isFavourite=!isFavourite;
    notifyListeners();
    try{
      final  response = await http.patch(Uri.parse("https://shopexx-49bc9-default-rtdb.firebaseio.com/products/$id.json"),body: jsonEncode({
        "isFavourite":isFavourite,
      }));
      if(response.statusCode>=400)
        {
          _setFavValue();
        }
    }
    catch(err){
      _setFavValue();
    }

  }
}
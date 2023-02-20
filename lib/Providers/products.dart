 import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http ;
import '../model/product.dart';
import '../model/httpException.dart';

class Products with ChangeNotifier{
  List<Product> _items= [
  ];
  List<Product> get items{
    return [..._items];
  }
  List<Product> get favouriteItems{
    return _items.where((prod) => prod.isFavourite==true).toList();
  }
  Future <void> fetchAndSetProducts() async{
    final  url =Uri.parse("https://shopexx-49bc9-default-rtdb.firebaseio.com/products.json");
    try{
      final response = await http.get(url);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String,dynamic>;
      List<Product> products=[];
      extractedData.forEach((prodId, prodData) { 
       products.add(Product(id: prodId,title: prodData["title"],description: prodData["description"],price: prodData["price"],imageUrl: prodData["imageUrl"],isFavourite: prodData["isFavourite"]));
      });
      _items= products ;
      notifyListeners();
      }
    catch(error){
      throw(error);
    }

  }

  Future <void> addProduct(Product product) async
  {
    // _items.add(value);
    try {
      final url = Uri.parse("https://shopexx-49bc9-default-rtdb.firebaseio.com/products.json");
      await http.post(url, body: json.encode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavourite': product.isFavourite,
      }));
      final newProduct = Product(id: "dfa",
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    }
    catch(err)
    {
      print(err);
      throw(err);
    }
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
 Future<void> updateProduct(String productId, Product existingProduct ) async
  {
    int idx = _items.indexWhere((prod) => prod.id==productId);
    if (idx>=0) {
      await http.patch(Uri.parse("https://shopexx-49bc9-default-rtdb.firebaseio.com/products/$productId.json"),body:
      json.encode({
        "title": existingProduct.title,
        "description": existingProduct.description,
        "price": existingProduct.price,
        "imageUrl": existingProduct.imageUrl
      })
      );
      _items[idx] = existingProduct;
      notifyListeners();
    }
  }
Future  <void> removeProduct(String id) async {
    final url =Uri.parse("https://shopexx-49bc9-default-rtdb.firebaseio.com/products/$id.json");
    final existingProductIndex= _items.indexWhere((element) => element.id==id);
    var prodct =_items[existingProductIndex];
    final response =await http.delete(url);
    _items.removeWhere((prod) => prod.id==id);
    notifyListeners();
      if (response.statusCode>=400){
      _items.insert(existingProductIndex,prodct);
       throw  HttpException("Cannot be deleted right now ");
      }

    }
  }

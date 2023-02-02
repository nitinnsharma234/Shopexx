import 'package:flutter/material.dart';
import 'package:shopexx/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  const ProductItem(this.id,this.title,this.imageUrl,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(footer: GridTileBar(
        title: Text(title),
        backgroundColor: Colors.black87,
        leading: IconButton(onPressed:null,icon: Icon(Icons.favorite,color: Theme.of(context).colorScheme.secondary,)),
        trailing: IconButton(icon:Icon(Icons.shopping_cart,color: Theme.of(context).colorScheme.secondary,), onPressed: () {  },),
      ),child: GestureDetector(onTap:(){
          Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: id);
      },child: Image.network(imageUrl,fit: BoxFit.cover,)),),
    );
  }
}

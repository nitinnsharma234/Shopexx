import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopexx/screens/edit_product_screen.dart';

import '../Providers/products.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({Key? key, required this.title, required this.imageUrl,required this.id})
      : super(key: key);
  final String title;
  final String id;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments:id );
            }, icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () async {
                 try{
                   await Provider.of<Products>(context,listen: false).removeProduct(id);
                 }
                 catch(error){
                   if (context.mounted)
                     {
                          if(ScaffoldMessenger.of(context).mounted)
                            {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Item Deletion Failed ")));

                            }
                     }
                 }
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
            )
          ],
        ),
      ),
    );
  }
}

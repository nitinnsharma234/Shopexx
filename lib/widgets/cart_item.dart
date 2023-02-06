import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/cart.dart' as ci;

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String productId;

  const CartItem(this.id, this.price, this.quantity, this.title,this.productId, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var  fc= Provider.of<ci.Cart>(context);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction:DismissDirection.endToStart,
      onDismissed: (direction) {
        fc.removeItem(productId);
      },
      confirmDismiss: (direction){
        return showDialog(context: context, builder: (ctx)  {
          return  AlertDialog(title: const Text("Are you sure ?")
            ,content: const Text("Do you want to remove the Item?"),actions: [
            TextButton(onPressed: (){Navigator.of(ctx).pop(false);}, child: const Text("No")),
            TextButton(onPressed: (){Navigator.of(ctx).pop(true);}, child: const Text("Yes")),
          ],);
        });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: Padding(
                padding: const EdgeInsets.all(5),
                child: CircleAvatar(
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: FittedBox(child: Text("\$$price"))),
                )),
            title: Text(title),
            subtitle: Text('Total:\$${(price * quantity)}'),
            trailing: Text('X $quantity'),
          ),
        ),
      ),
    );
  }
}

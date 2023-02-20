import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopexx/widgets/OrderItemCard.dart';
import 'package:shopexx/widgets/appDrawer.dart';

import '../Providers/orders.dart';


class OrderScreen extends StatelessWidget {
static const routeName = '/orders';
const OrderScreen({Key? key}) : super(key: key);


  /*var _isLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading=true;
      });
      await Provider.of<Orders>(context,listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading=false;
      });
    });
  }*/
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context,listen: false);
    return
      Scaffold(
        appBar: AppBar(title: const Text("Your Orders"),),
    drawer: const AppDrawer(),
    body: FutureBuilder(builder: (ctx,snapshotData){
      if(snapshotData.connectionState==ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
      }
      else if (snapshotData.error!=null)
        {
         return  const Center(child:Text("Can't Load Right Now "));
        }
      else{
       return  Consumer<Orders>(builder: (ctx,ordersData,_){
          return
            ListView.builder(itemBuilder: (ctx,i){
              return OrderItemCard(order: ordersData.orders[i]);
            },itemCount: ordersData.orders.length,);
        }

       );}

    },future: Provider.of<Orders>(context,listen: false).fetchAndSetOrders() ),);

  }
}

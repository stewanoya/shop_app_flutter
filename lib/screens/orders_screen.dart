import 'package:flutter/material.dart';
import 'package:shop_app_practice/widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = "/orders";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  var _ordersFuture;
  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    // was commented out because it created infinite loop with that^ listener with consumer below
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Orders"),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: _ordersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.error != null) {
                  // there will be an error
                  // Error handlding here
                  return Center(
                    child: Text("Some error occured"),
                  );
                } else {
                  return Consumer<Orders>(
                      builder: (context, orderData, child) => ListView.builder(
                            itemCount: orderData.orders.length,
                            itemBuilder: (context, index) =>
                                OrderItem(orderData.orders[index]),
                          ));
                }
              }
            }));
  }
}

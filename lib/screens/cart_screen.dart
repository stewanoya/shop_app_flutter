import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      "\$${cart.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              ?.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text("Order Now!"),
                    onPressed: () {
                      // don't really care about listening to changes
                      // I just want to dispatch this action
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      // clear cart is still listening to changes because it is in the widget context with the provider
                      cart.clearCart();
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // will take as much space as available
          Expanded(
              child: ListView.builder(
            itemCount: cart.itemCount,
            itemBuilder: (context, index) => CartItem(
              // because our list of items from provider was a map (a js Object)
              // we needed to access the values
              // because the values are "Iterable", using to list makes it a regular list to work with.
              id: cart.items.values.toList()[index].id,
              productId: cart.items.keys.toList()[index],
              price: cart.items.values.toList()[index].price,
              title: cart.items.values.toList()[index].title,
              quantity: cart.items.values.toList()[index].quantity,
            ),
          )),
        ],
      ),
    );
  }
}

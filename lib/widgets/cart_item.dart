import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final DateTime id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem({
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    var total = price * quantity;

    // the dismissible widget is a stateful widget
    // allows for the item to be swiped away
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          right: 20,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      // says which way dismissible can be dismissed
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text("\$${price}"),
                  ),
                ),
              ),
              title: Text(title!),
              subtitle: Text("Total: \$${total}"),
              trailing: Text("Quantity: $quantity"),
            ),
          )),
    );
  }
}

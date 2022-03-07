import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final DateTime id;
  final double price;
  final int quantity;
  final String title;

  CartItem({
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var total = price * quantity;

    return Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Text("\$${price}"),
              ),
            ),
            title: Text(title!),
            subtitle: Text("Total: \$${total}"),
            trailing: Text("Quantity: $quantity"),
          ),
        ));
  }
}

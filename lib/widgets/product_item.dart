import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_practice/providers/cart.dart';

import '../screens/product_details_screen.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  //
  // ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    var productItem = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: productItem.id);
          },
          child: Image.network(
            productItem.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(productItem.isFavorite
                ? Icons.favorite
                : Icons.favorite_border),
            onPressed: () {
              productItem.toggleFavorite();
            },
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            productItem.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                cart.addItem(
                  productItem.id,
                  productItem.price,
                  productItem.title,
                );
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Item added to cart!",
                    ),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: "undo",
                      onPressed: () {
                        cart.removeSingleItem(productItem.id);
                      },
                    ),
                  ),
                ); // establishes a connection to the nearest scaffold widget - wouldn't work if we tried to access it in the same widget we used scaffold
              },
              color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}

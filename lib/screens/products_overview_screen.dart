import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Fake Shop"), actions: <Widget>[
        PopupMenuButton(
          onSelected: (FilterOptions selectedValue) {
            setState(() {
              if (selectedValue == FilterOptions.Favorites) {
                _showOnlyFavorites = true;
              } else {
                _showOnlyFavorites = false;
              }
            });
          },
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) => const [
            PopupMenuItem(
              child: Text("Only Favorites"),
              value: FilterOptions.Favorites,
            ),
            PopupMenuItem(
              child: Text("Show All"),
              value: FilterOptions.All,
            ),
          ],
        )
      ]),
      // will render products on screen and not the ones passed until they are in view.
      // good for long grid lists
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}

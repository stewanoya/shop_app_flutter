import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Fake Shop"),
      ),
      // will render products on screen and not the ones passed until they are in view.
      // good for long grid lists
      body: ProductsGrid(),
    );
  }
}

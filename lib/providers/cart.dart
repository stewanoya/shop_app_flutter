import 'package:flutter/foundation.dart';

class CartItem {
  final DateTime id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    notifyListeners();
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (prev) => CartItem(
              id: prev.id,
              title: prev.title,
              price: prev.price,
              quantity: prev.quantity + 1));
      notifyListeners();
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
      notifyListeners();
    }
  }
}

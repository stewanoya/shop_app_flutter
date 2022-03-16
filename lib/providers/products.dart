import 'package:flutter/material.dart';
import 'dart:convert';
import './product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    /*
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),*/
  ];

  // var _showFavoritesOnly = false;
  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((item) => item.isFavorite == true).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((el) => el.isFavorite == true).toList();
  }

  // void showFavorites() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }
  //
  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://flutter-shop-351da-default-rtdb.firebaseio.com/products.json');
    try {
      final List<Product> loadedProducts = [];
      var response = await http.get(url);
      var data = json.decode(response.body) as Map<String, dynamic>;
      data.forEach((id, productData) {
        loadedProducts.add(Product(
            id: id,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            isFavorite: productData['isFavorite'],
            imageUrl: productData['imageUrl']));
      });
      _items = [...loadedProducts];
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://flutter-shop-351da-default-rtdb.firebaseio.com/products.json');
    try {
      var response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          }));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> updateProduct(Product updatedProduct) async {
    final url = Uri.parse(
        'https://flutter-shop-351da-default-rtdb.firebaseio.com/products/${updatedProduct.id}.json');
    await http.patch(url,
        body: json.encode({
          'title': updatedProduct.title,
          'description': updatedProduct.description,
          'imageUrl': updatedProduct.imageUrl,
          'price': updatedProduct.price,
        }));
    int productIndex = _items.indexWhere((el) => el.id == updatedProduct.id);
    _items[productIndex] = updatedProduct;
    notifyListeners();
  }

  Future<void> removeProduct(String id) async {
    final url = Uri.parse(
        'https://flutter-shop-351da-default-rtdb.firebaseio.com/products/$id.json');
    await http.delete(url);
    _items.removeWhere((el) => el.id == id);
    notifyListeners();
  }
}

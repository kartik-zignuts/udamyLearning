import 'package:flutter/material.dart';

class CartItemModel {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItemModel(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class CartProvider extends ChangeNotifier {
  Map<String, CartItemModel>? _items = {};

  Map<String, CartItemModel> get items {
    return {..._items!};
  }

  int? get itemCount {
    return _items?.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items?.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addProduct(
      {required String productId,
      required String title,
      required double price}) {
    if (_items!.containsKey(productId)) {
      _items!.update(
          productId,
          (exitingProduct) => CartItemModel(
              id: exitingProduct.id,
              title: exitingProduct.title,
              quantity: exitingProduct.quantity + 1,
              price: exitingProduct.price));
    } else {
      _items!.putIfAbsent(
          productId,
          () => CartItemModel(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  //delete Item
  void removeItem(String productId) {
    _items!.remove(productId);
    notifyListeners();
  }

  //remove single item
  void removeSinglItem(String productId) {
    if (!_items!.containsKey(productId)) {
      return;
    }
    if (_items![productId]!.quantity > 1) {
      _items?.update(
          productId,
          (exitingProduct) => CartItemModel(
              id: exitingProduct.id,
              title: exitingProduct.title,
              quantity: exitingProduct.quantity - 1,
              price: exitingProduct.price));
    } else {
      _items!.remove(productId);
    }
    notifyListeners();
  }

  //clear cart
  void clear() {
    _items?.clear();
    notifyListeners();
  }
}

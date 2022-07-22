import 'package:flutter/material.dart';
import 'package:untitled/provider/cart_provider.dart';

class OrderItemModel {
  final String id;
  final double amount;
  final List<CartItemModel> products;
  final DateTime dateTime;

  OrderItemModel(
      {required this.amount,
      required this.dateTime,
      required this.id,
      required this.products});
}

class OrderProvider with ChangeNotifier {
  List<OrderItemModel> _orders = [];

  List<OrderItemModel> get orders {
    return [..._orders];
  }

  void addOrder(
      {required List<CartItemModel> products, required double total}) {
    _orders.insert(
        0,
        OrderItemModel(
            amount: total,
            dateTime: DateTime.now(),
            id: DateTime.now().toString(),
            products: products));
    notifyListeners();
  }
}

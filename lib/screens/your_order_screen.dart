import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/orders_provider.dart';
import 'package:untitled/widget/app_drawar.dart';
import 'package:untitled/widget/order_item.dart';

class YourOrderScreen extends StatefulWidget {
  const YourOrderScreen({Key? key}) : super(key: key);
  static const routeName = '/your-Order';

  @override
  State<YourOrderScreen> createState() => _YourOrderScreenState();
}

class _YourOrderScreenState extends State<YourOrderScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    OrderProvider orderData = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Order')),
      drawer: const AppDrawar(),
      body: ListView.builder(
          itemBuilder: ((context, i) =>
              YourOrderItem(order: orderData.orders[i])),
          itemCount: orderData.orders.length),
    );
  }
}

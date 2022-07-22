import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/cart_provider.dart';
import 'package:untitled/provider/orders_provider.dart';
import 'package:untitled/widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Column(
        children: [
          Card(
            elevation: 5,
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    label:
                        Text('\$${cartProvider.totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color,
                            )),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<OrderProvider>(context, listen: false)
                          .addOrder(
                              products: cartProvider.items.values.toList(),
                              total: cartProvider.totalAmount);
                      cartProvider.clear();
                    },
                    child: const Text(
                      'ODER NOW',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Divider(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Center(
                child: Text(
                  'Items',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Divider(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemBuilder: (context, index) => CartItem(
                  id: cartProvider.items.values.toList()[index].id,
                  productKey: cartProvider.items.keys.toList()[index],
                  price: cartProvider.items.values.toList()[index].price,
                  quantity: cartProvider.items.values.toList()[index].quantity,
                  title: cartProvider.items.values.toList()[index].title),
              itemCount: cartProvider.items.length,
            ),
          ))
        ],
      ),
    );
  }
}

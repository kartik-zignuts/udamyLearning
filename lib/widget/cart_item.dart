// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/cart_provider.dart';

class CartItem extends StatelessWidget {
  final String title;
  final double price;
  final int quantity;
  final String id;
  final String productKey;

  const CartItem(
      {Key? key,
      required this.id,
      required this.productKey,
      required this.price,
      required this.quantity,
      required this.title})
      : super(key: key);

  Future<bool?> showConfirmDiolog(BuildContext cn) {
    return showDialog(
        context: cn,
        builder: (ctx) => AlertDialog(
              title: const Text('Are you sure?'),
              content:
                  const Text('Do you want to remove the item from the cart?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                    },
                    child: const Text('Yes')),
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                    child: const Text('No'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      onDismissed: ((direction) {
        Provider.of<CartProvider>(context, listen: false)
            .removeItem(productKey);
      }),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showConfirmDiolog(context);
      },
      background: Container(
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Theme.of(context).errorColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          icon: const Icon(Icons.delete),
          iconSize: 40,
          color: Colors.white,
          onPressed: () {},
        ),
      ),
      child: Card(
        // margin: const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 0.8)),
        elevation: 0,
        child: ListTile(
          leading: CircleAvatar(
            radius: 29,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: FittedBox(
                child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('\$${price}',
                  style: const TextStyle(
                    color: Colors.white,
                  )),
            )),
          ),
          title: Text(title,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold)),
          subtitle: Text('Total = ${price * quantity} ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              )),
          trailing: Text('$quantity×',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 20)),
        ),
      ),
    );
  }
}

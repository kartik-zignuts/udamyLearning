import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/provider/orders_provider.dart';

class YourOrderItem extends StatefulWidget {
  final OrderItemModel order;

  const YourOrderItem({Key? key, required this.order}) : super(key: key);

  @override
  State<YourOrderItem> createState() => _YourOrderItemState();
}

class _YourOrderItemState extends State<YourOrderItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          _isExpanded
              ? Container(
                  height: min(widget.order.products.length * 20 + 8, 180),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: widget.order.products
                        .map((e) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e.title,
                                ),
                                Text(
                                  " ${e.quantity.toString()} × ${e.price}",
                                ),
                              ],
                            ))
                        .toList(),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

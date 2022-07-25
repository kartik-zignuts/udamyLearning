import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/products_provider.dart';
import 'package:untitled/screens/edit_product_screen.dart';

class ManageProductItem extends StatelessWidget {
  final String id;
  final String titlel;
  final String imageUrl;

  const ManageProductItem(
      {Key? key,
      required this.id,
      required this.titlel,
      required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(titlel),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, EditProductScreen.routeName,
                      arguments: id);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: const Text('Are you sure?'),
                            content: const Text(
                                'Do you want to remove this product?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Provider.of<ProductsProvider>(context,
                                            listen: false)
                                        .deleteProduct(context, id);
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text('Yes')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text('No'))
                            ],
                          ));
                },
                icon: Icon(Icons.delete, color: Theme.of(context).errorColor))
          ],
        ),
      ),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}

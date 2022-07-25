import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/products_provider.dart';
import 'package:untitled/screens/edit_product_screen.dart';
import 'package:untitled/widget/app_drawar.dart';
import 'package:untitled/widget/manage_producdt_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/manage-product';
  const UserProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsProvider productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Product'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const AppDrawar(),
      body: ListView.builder(
          itemBuilder: (_, i) => Column(
                children: [
                  ManageProductItem(
                    id: productData.items[i].id,
                    imageUrl: productData.items[i].imageUrl,
                    titlel: productData.items[i].title,
                  ),
                  const CustomeDivider(),
                ],
              ),
          itemCount: productData.items.length),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/products_model.dart';
import 'package:untitled/provider/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)!.settings.arguments as String;
    // final loadedProduct = Provider.of<ProductsProvider>(context)
    //     .items
    //     .firstWhere((element) => element.id == productId);
    final Product loadedProduct =
        Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 1),
                    spreadRadius: 5,
                    blurRadius: 20,
                    color: Theme.of(context).colorScheme.primary),
                const BoxShadow(
                    offset: Offset(0, 0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    color: Colors.black)
              ]),
              width: double.infinity,
              height: 250,
              child: Hero(
                tag: 'product-image-key$productId',
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "\$${loadedProduct.price.toString()}",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                loadedProduct.description.toString(),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/products_provider.dart';
import 'package:untitled/widget/product_item_widget.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavorites;
  const ProductGrid({Key? key, required this.showFavorites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context, listen: false);
    final products =
        showFavorites ? productData.favoriteItems : productData.items;
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1.4),
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        itemBuilder: (ctx, i) {
          return ChangeNotifierProvider.value(
            value: products[i],
            child: const ProductItem(
                // isFavorite: _products[i].isFavorite,
                //  title: _products[i].title,
                //  id: _products[i].id,
                //  imageUrl: _products[i].imageUrl,
                ),
          );
        });
  }
}

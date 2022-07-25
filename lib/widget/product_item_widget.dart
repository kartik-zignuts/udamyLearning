import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/cart_provider.dart';
import 'package:untitled/provider/products_model.dart';
import 'package:untitled/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // bool isFavorite;
  // final String imageUrl;
  // final String title;
  const ProductItem({
    Key? key,
    // required this.id,
    // required this.title,
    // required this.imageUrl,
    // required this.isFavorite
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
    );
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Card(
      elevation: 7.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GridTile(
          footer: Container(
            color: Colors.black87,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<Product>(builder: (cnt, providerData, _) {
                  return IconButton(
                    onPressed: () {
                      providerData.toggleFavoriteState();
                    },
                    icon: Icon(
                        providerData.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: Theme.of(context).colorScheme.secondary),
                  );
                }),
                Flexible(
                  child: Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      cart.addProduct(
                          productId: product.id,
                          title: product.title,
                          price: product.price);
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Item added to cart successfully'),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            cart.removeSinglItem(product.id);
                          },
                        ),
                      ));
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
              ],
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                  arguments: product.id);
            },
            child: Hero(
              tag: 'product-image-key${product.id}',
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

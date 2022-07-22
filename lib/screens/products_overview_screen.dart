import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/cart_provider.dart';
import 'package:untitled/screens/cart_screen.dart';
import 'package:untitled/widget/app_drawar.dart';
import 'package:untitled/widget/badge.dart';
import 'package:untitled/widget/product_grid.dart';

// ignore: constant_identifier_names
enum FilterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Shop'),
          actions: [
            PopupMenuButton(
                onSelected: (FilterOptions selectedValue) {
                  setState(() {
                    if (selectedValue == FilterOptions.Favorites) {
                      _showFavorites = true;
                    } else {
                      _showFavorites = false;
                    }
                  });
                },
                icon: const Icon(Icons.more_vert),
                itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: FilterOptions.Favorites,
                        child: Text('Only Favorite'),
                      ),
                      const PopupMenuItem(
                          value: FilterOptions.All, child: Text('Show All')),
                    ]),
            Consumer<CartProvider>(
              builder: ((_, cart, ch) => Badge(
                    value: cart.itemCount.toString(),
                    child: ch!,
                  )),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            )
          ],
        ),
        drawer: const AppDrawar(),
        body: ProductGrid(showFavorites: _showFavorites));
  }
}

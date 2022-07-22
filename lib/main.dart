import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/cart_provider.dart';
import 'package:untitled/provider/orders_provider.dart';
import 'package:untitled/provider/products_provider.dart';
import 'package:untitled/screens/cart_screen.dart';
import 'package:untitled/screens/edit_product_screen.dart';
import 'package:untitled/screens/product_details_screen.dart';
import 'package:untitled/screens/products_overview_screen.dart';
import 'package:untitled/screens/user_product_screen.dart';
import 'package:untitled/screens/your_order_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => OrderProvider())
      ],
      child: MaterialApp(
          title: 'My Shop',
          theme: ThemeData(
            canvasColor: Colors.yellow.shade50,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.brown)
                .copyWith(secondary: Colors.yellow.shade900),
            fontFamily: 'Lato',
          ),
          home: const ProductOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
            CartScreen.routeName: (ctx) => const CartScreen(),
            YourOrderScreen.routeName: (ctx) => const YourOrderScreen(),
            UserProductScreen.routeName: (ctx) => const UserProductScreen(),
            EditProductScreen.routeName: (ctx) => const EditProductScreen(),
          }),
    );
  }
}

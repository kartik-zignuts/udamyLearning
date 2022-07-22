import 'package:flutter/material.dart';
import 'package:untitled/screens/user_product_screen.dart';
import 'package:untitled/screens/your_order_screen.dart';

class AppDrawar extends StatelessWidget {
  const AppDrawar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        SizedBox(
          width: double.infinity,
          // color: Theme.of(context).colorScheme.primary,
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Hello Kartik...!',
              textAlign: TextAlign.values[2],
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const CustomeDrawarListtTail(
            title: 'Shop', puchName: '/', icon: Icons.shop),
        const CustomeDivider(),
        const CustomeDrawarListtTail(
            title: 'Order',
            puchName: YourOrderScreen.routeName,
            icon: Icons.payment),
        const CustomeDivider(),
        const CustomeDrawarListtTail(
            title: 'Manage Product',
            puchName: UserProductScreen.routeName,
            icon: Icons.edit),
        const CustomeDivider(),
      ]),
    );
  }
}

class CustomeDivider extends StatelessWidget {
  const CustomeDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 6,
      thickness: 1,
    );
  }
}

class CustomeDrawarListtTail extends StatelessWidget {
  final String title;
  final String puchName;
  final IconData icon;
  const CustomeDrawarListtTail(
      {Key? key,
      required this.title,
      required this.puchName,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
        size: 30,
      ),
      title: Text(title),
      onTap: (() => Navigator.pushReplacementNamed(context, puchName)),
    );
  }
}

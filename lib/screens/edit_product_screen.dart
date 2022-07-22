import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key, r}) : super(key: key);
  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _discriptionFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            child: SingleChildScrollView(
                child: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_discriptionFocusNode);
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('Price'),
              ),
            ),
            TextFormField(
              maxLines: 3,
              focusNode: _discriptionFocusNode,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                label: Text('Discripton'),
              ),
            )
          ],
        ))),
      ),
    );
  }
}

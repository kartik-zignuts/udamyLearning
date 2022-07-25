import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/products_model.dart';
import 'package:untitled/provider/products_provider.dart';
import 'package:untitled/widget/product_item_widget.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key, r}) : super(key: key);
  static const routeName = '/edit-product';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _imgeUrlFocusNode = FocusNode();
  final _discriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _edditedProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');
  var isInit = true;

  @override
  void initState() {
    _imgeUrlFocusNode.addListener(_updatImageFocuseNode);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final currentProductId = ModalRoute.of(context)!.settings.arguments;
      if (currentProductId != null) {
        _edditedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findById(currentProductId.toString());
        _imageUrlController.text = _edditedProduct.imageUrl;
      }
    }

    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _imgeUrlFocusNode.removeListener(_updatImageFocuseNode);
    _discriptionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updatImageFocuseNode() {
    if (!_imgeUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('https://') &&
              !_imageUrlController.text.startsWith('http://')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveData() {
    print("this is the product id ----------- ${_edditedProduct.id}");
    final isFormDataValid = _formKey.currentState!.validate();
    if (!isFormDataValid) {
      return;
    }
    _formKey.currentState!.save();

    if (_edditedProduct.id != '') {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_edditedProduct.id, _edditedProduct);
    } else {
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_edditedProduct);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Screen'),
        actions: [
          IconButton(
              onPressed: () {
                _saveData();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
              children: [
                TextFormField(
                  initialValue: _edditedProduct.title,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Title';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _edditedProduct = Product(
                        id: _edditedProduct.id,
                        title: value.toString(),
                        description: _edditedProduct.description,
                        price: _edditedProduct.price,
                        imageUrl: _edditedProduct.imageUrl,
                        isFavorite: _edditedProduct.isFavorite);
                  },
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  initialValue: _edditedProduct.price.toString(),
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_discriptionFocusNode);
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Price'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Price';
                    } else if (double.tryParse(value) == null) {
                      return 'Please enter a valid input';
                    } else if (double.parse(value) <= 0) {
                      return 'Please enter a number greater then the Zero';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _edditedProduct = Product(
                        id: _edditedProduct.id,
                        title: _edditedProduct.title,
                        description: _edditedProduct.description,
                        price: double.parse(value!),
                        isFavorite: _edditedProduct.isFavorite,
                        imageUrl: _edditedProduct.imageUrl);
                  },
                ),
                TextFormField(
                  maxLines: 3,
                  focusNode: _discriptionFocusNode,
                  initialValue: _edditedProduct.description,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    label: Text('Discripton'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a discription';
                    } else if (value.length < 10) {
                      return 'Discription should be least 10 characters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _edditedProduct = Product(
                        id: _edditedProduct.id,
                        title: _edditedProduct.title,
                        description: value!,
                        isFavorite: _edditedProduct.isFavorite,
                        price: _edditedProduct.price,
                        imageUrl: _edditedProduct.imageUrl);
                  },
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(right: 10, top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Center(child: Text('Enter a Url'))
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _imageUrlController,
                      focusNode: _imgeUrlFocusNode,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        label: Text('Enter a Url'),
                      ),
                      onFieldSubmitted: (_) {
                        _saveData();
                      },
                      validator: (value) {
                        if (kDebugMode) {
                          print(value!.startsWith('https://'));
                          print(value.startsWith('http://'));
                          print(value.endsWith('.png'));
                          print(value.endsWith('.jpg'));
                          print(value.endsWith('.jpeg'));
                        }
                        if (value!.isEmpty) {
                          return 'Please enter the URL';
                        } else if (!value.startsWith('https://') &&
                            !value.startsWith('http://')) {
                          return 'Please enter a valid URL';
                        } else if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg')) {
                          return 'Please enter valid image URL';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _edditedProduct = Product(
                            id: _edditedProduct.id,
                            title: _edditedProduct.title,
                            description: _edditedProduct.description,
                            price: _edditedProduct.price,
                            isFavorite: _edditedProduct.isFavorite,
                            imageUrl: value!);
                      },
                    ),
                  ),
                ])
              ],
            ))),
      ),
    );
  }
}

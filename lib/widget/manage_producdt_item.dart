import 'package:flutter/material.dart';

class ManageProductItem extends StatelessWidget {
  final String titlel;
  final String imageUrl;

  const ManageProductItem(
      {Key? key, required this.titlel, required this.imageUrl})
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
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                )),
            IconButton(
                onPressed: () {},
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

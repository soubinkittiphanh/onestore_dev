import 'package:flutter/material.dart';
import 'package:onestore/models/product.dart';
import 'package:onestore/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CompoActionBar extends StatefulWidget {
  final Product product;
  const CompoActionBar({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<CompoActionBar> createState() => _CompoActionBarState();
}

class _CompoActionBarState extends State<CompoActionBar> {
  bool _isfavourite = false;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Align(
      alignment: Alignment.bottomRight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 30,
          color: Colors.red.withOpacity(0.5),
          child: FittedBox(
            fit: BoxFit.fill,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    cartProvider.addCart(widget.product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        dismissDirection: DismissDirection.down,
                        backgroundColor: Colors.purple[600],
                        content: Text(
                          "ເພີ່ມໄປຍັງລາຍການແລ້ວ",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        action: SnackBarAction(
                          label: "Cancel",
                          onPressed: () {
                            cartProvider.removeCart(widget.product.proId);
                          },
                        ),
                        duration: Duration(
                          seconds: 1,
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isfavourite = !_isfavourite;
                    });
                  },
                  icon: Icon(
                    _isfavourite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          // child: Text('hi'),
        ),
      ),
    );
  }
}

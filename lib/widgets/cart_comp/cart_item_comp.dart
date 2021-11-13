import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onestore/models/product.dart';
import 'package:onestore/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItemComp extends StatelessWidget {
  final Product product;
  const CartItemComp({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final f = NumberFormat("#,###");
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItem = cartProvider.cartItemId(product.proId);
    return Dismissible(
      key: Key(product.proId.toString()),
      background: Container(
        height: 20,
        color: Colors.white,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        print("$direction");
        cartProvider.removeCart(cartItem.proId);
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Stack(children: [
            FittedBox(
              child: Text(
                "x ${cartItem.qty}",
              ),
            ),
          ]),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("ຊື່ສິນຄ້າ: ${product.proName}",
                style: Theme.of(context).textTheme.bodyText2),
            Text("ລາຄາ: ${f.format(cartItem.price)}",
                style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
        subtitle: Row(
          children: [
            Spacer(),
            Text(
              "${f.format(cartItem.priceTotal)} ກີບ",
              style: const TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
        isThreeLine: true,
        trailing: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.delete_forever),
          onPressed: () {
            cartProvider.removeCart(cartItem.proId);
          },
        ),
      ),
    );
  }
}

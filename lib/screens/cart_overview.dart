import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onestore/helper/order_helper.dart';
import 'package:onestore/providers/cart_provider.dart';
import 'package:onestore/providers/product_provider.dart';
import 'package:onestore/widgets/cart_comp/cart_item_comp.dart';
import 'package:provider/provider.dart';
// import 'package:onestore/helper/order_helper.dart' as orderHelper;

class CartOverview extends StatefulWidget {
  const CartOverview({Key? key}) : super(key: key);

  @override
  _CartOverviewState createState() => _CartOverviewState();
}

class _CartOverviewState extends State<CartOverview> {
  final f = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final cartItem = cartProvider.cartItem;

    Future<void> _showInfoDialogIos(String info) async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text("Cupertino"),
              content: Text(info),
              actions: [
                CupertinoDialogAction(
                    child: TextButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
                CupertinoDialogAction(
                    child: TextButton(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
              ],
            );
          });
    }

    Future<void> _showInfoDialog(String info) async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Material"),
              content: Text(info),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Yes"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No"),
                ),
              ],
            );
          });
    }

    void placeOrder() async {
      print("object");
      // sendOrder(cartItem);
      context.loaderOverlay.show();
      String res = await OrderHelper.sendOrder(cartItem);
      print("RESPONSE: " + res);
      if (res.endsWith("completed")) {
        print("completed case");
        cartProvider.clearCartItem();
      }
      await _showInfoDialogIos(res);
      context.loaderOverlay.hide();
    }

    return LoaderOverlay(
      overlayOpacity: 0.5,
      child: Container(
        decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(80),
              bottomRight: Radius.circular(90),
            ),
            color: Colors.red),
        // color: Colors.red,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "ລາຄາລວມທັງໝົດ: ",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  "${f.format(cartProvider.cartCost)} ກີບ",
                  style: Theme.of(context).textTheme.headline6,
                ),

                TextButton(
                  child: const Text(
                    "ສັ່ງຊື້ເລີຍ",
                    // style: Theme.of(context).textTheme.bodyText2,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: 'Noto San Lao',
                        fontStyle: FontStyle.normal,
                        color: Colors.white),
                  ),
                  onPressed: placeOrder,
                ),
                // const ElevatedButton(
                //   onPressed: null,
                //   child: Text("Order"),
                // ),
              ],
            ),
            const Divider(
              color: Colors.white,
            ),
            Flexible(
              // height: 500,
              child: ListView.builder(
                itemCount: cartItem.length,
                itemBuilder: (ctx, id) => CartItemComp(
                  product: productProvider.productId(cartItem[id].proId),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

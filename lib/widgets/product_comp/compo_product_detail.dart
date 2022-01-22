import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onestore/getxcontroller/cart_controller.dart';
import 'package:onestore/models/product.dart';
import 'compo_action_bar_model.dart';

class ProductDetailComp extends StatefulWidget {
  const ProductDetailComp(
      {Key? key, required this.product, required this.pageChange})
      : super(key: key);
  final Product product;
  final Function pageChange;

  @override
  State<ProductDetailComp> createState() => _ProductDetailCompState();
}

class _ProductDetailCompState extends State<ProductDetailComp> {
  final cartProvider = Get.put(CartController());
  int orderQuantity = 1;
  _addOne() {
    log("add...");
    setState(() {
      orderQuantity += 1;
    });
  }

  _removeOne() {
    log("remove...");
    if (orderQuantity == 1) {
      return;
    }
    setState(() {
      orderQuantity -= 1;
    });
  }

  void _addToCardAndGo() {
    ScaffoldMessenger.of(context).clearSnackBars();
    cartProvider.addCart(widget.product, orderQuantity);
    Navigator.of(context).pop();
    widget.pageChange(1);
  }

  @override
  Widget build(BuildContext context) {
    // final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final f = NumberFormat("#,###");
    final deviceSize = MediaQuery.of(context).size;
    // final cartController = Get.put(CartController());

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.pageChange(1);
            },
            icon: FittedBox(
              fit: BoxFit.fitHeight,
              child: Column(
                children: [
                  GetBuilder<CartController>(builder: (ctr) {
                    return Text(ctr.cartCount.toString());
                  }),
                  const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: deviceSize.height * 0.3,
                      ),
                      // height: 500,
                      padding: EdgeInsets.only(
                        top: deviceSize.height * 0.12,
                        left: 30,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("ຈຳນວນຂາຍແລ້ວ: ${widget.product.saleCount}"),
                              Card(
                                color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "ສ່ວນລົດ: ${widget.product.retailPrice} %",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: _addOne,
                                icon: const Icon(Icons.add),
                              ),
                              Text(orderQuantity.toString()),
                              IconButton(
                                onPressed: _removeOne,
                                icon: const Icon(Icons.remove),
                              ),
                            ],
                          ),
                          CompoActionBarModel(
                            product: widget.product,
                            qty: orderQuantity,
                            addNgo: _addToCardAndGo,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  const Text("ລາຍລະອຽດສິນຄ້າ: ",
                                      style: TextStyle(fontSize: 22)),
                                  Text(widget.product.proDesc),
                                  const SizedBox(
                                    width: 200,
                                    child: Divider(
                                      // thickness: 10,
                                      color: Colors.red,
                                    ),
                                  ),
                                  if (widget.product.retailPrice > 0)
                                    Text(
                                      f.format(widget.product.proPrice),
                                      style: const TextStyle(
                                          color: Colors.red,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  Text(
                                      "ລາຄາ: ${f.format(widget.product.proPrice - (widget.product.proPrice * widget.product.retailPrice / 100))}"),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.proName,
                            style: const TextStyle(
                              fontFamily: 'open sans',
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              fontSize: 32,
                            ),
                          ),
                          Text(
                            "ຈຳນວນ ສຕັອກ: ${widget.product.stock}",
                            style: const TextStyle(
                              fontFamily: 'noto san lao',
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              // fontSize: 32,
                            ),
                          ),
                          Row(
                            children: [
                              // Text("${widget.product.proPrice}"),
                              SizedBox(
                                width: deviceSize.width * 0.2,
                              ),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: widget.product.proImagePath
                                          .contains("No image")
                                      ? const Text('No image')
                                      : CachedNetworkImage(
                                          imageUrl: widget.product.proImagePath,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                height: deviceSize.height,
              )
            ],
          ),
        ),
      ),
    );
  }
}

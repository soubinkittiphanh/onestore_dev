import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onestore/getxcontroller/cart_controller.dart';
import 'package:onestore/getxcontroller/product_controller.dart';
import 'package:onestore/models/product.dart';
import 'package:onestore/widgets/cart_comp/cart_oview_comp.dart';

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
  final cartController = Get.put(CartController());
  final productContr = Get.put(ProductController());
  final orderQuantity = TextEditingController();
  final f = NumberFormat("#,###");
  // int orderQuantity = 1;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      orderQuantity.text = "1";
      cartController.addCartNoCardCar(
          widget.product, int.parse(orderQuantity.text));
    });
  }

  @override
  void dispose() {
    cartController.clearCartItem();
    super.dispose();
  }

  _addOneState() {
    if (orderQuantity.text == "10") {
      return;
    }
    setState(() {
      orderQuantity.text =
          (1 + int.parse(orderQuantity.text.toString())).toString();
    });
    cartController.addCartNoCardCar(
        widget.product, int.parse(orderQuantity.text));
  }

  _removeOneState() {
    if (int.parse(orderQuantity.text) == 0) return;
    if (int.parse(orderQuantity.text) == 1) {
      return;
      // return cartController.clearCartItem();
    }
    cartController.removeOneCart(widget.product);
    setState(() {
      orderQuantity.text = (int.parse(orderQuantity.text) - 1).toString();
    });
  }

  // void _addToCardAndGo() {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   cartController.addCart(widget.product,int.parse( orderQuantity.text));
  //   Navigator.of(context).pop();
  //   widget.pageChange(1);
  // }

  @override
  Widget build(BuildContext context) {
    // final cartController = Provider.of<cartController>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //       widget.pageChange(1);
        //     },
        //     icon: FittedBox(
        //       fit: BoxFit.fitHeight,
        //       child: Column(
        //         children: [
        //           GetBuilder<CartController>(builder: (ctr) {
        //             return Text(ctr.cartCount.toString());
        //           }),
        //           const Icon(
        //             Icons.shopping_cart_outlined,
        //             color: Colors.white,
        //           ),
        //         ],
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: SafeArea(
        child: LoaderOverlay(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(
                //   child:
                Stack(
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
                          SizedBox(
                            height: deviceSize.height * 0.11,
                          ),
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
                          Container(
                            width: deviceSize.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: _addOneState,
                                  icon: const Icon(Icons.add),
                                ),
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    controller: orderQuantity,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontFamily: "noto san lao"),
                                    onChanged: (val) {
                                      log("VALUE: " + val);
                                      if (val.isEmpty) {
                                        return;
                                      } else if (int.parse(val) == 0) {
                                        return;
                                      } else if (int.parse(val) > 10) {
                                        orderQuantity.text = "9";
                                        return;
                                      }
                                      // _addOneState();
                                      cartController.addCartNoCardCar(
                                          widget.product,
                                          int.parse(orderQuantity.text));
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'ຈນ',
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: _removeOneState,
                                  icon: const Icon(Icons.remove),
                                ),
                              ],
                            ),
                          ),
                          // CompoActionBarModel(
                          //   product: widget.product,
                          //   qty: orderQuantity,
                          //   addNgo: _addToCardAndGo,
                          // ),
                          SizedBox(
                            width: deviceSize.width * 0.9,
                            child: const Divider(
                              // thickness: 10,
                              color: Colors.red,
                            ),
                          ),

                          CartOviewComp(pageChange: () => {}),

                          const Text(
                            "ລາຍລະອຽດສິນຄ້າ: ",
                            style: TextStyle(fontSize: 22),
                          ),
                          // FittedBox(
                          //   child:
                          Text(widget.product.proDesc),
                          //   fit: BoxFit.contain,
                          // ),
                          const SizedBox(
                            width: 200,
                            child: Divider(
                              // thickness: 10,
                              color: Colors.red,
                            ),
                          ),
                          // CartOviewComp(pageChange: () => {}),
                          if (widget.product.retailPrice > 0)
                            Text(
                              f.format(widget.product.proPrice),
                              style: const TextStyle(
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          Text(
                            "ລາຄາ: ${f.format(widget.product.proPrice - (widget.product.proPrice * widget.product.retailPrice / 100))}",
                          ),

                          // ],
                          // )
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
                              fontFamily: 'noto san lao',
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
                                width: deviceSize.width * 0.24,
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
                                          height: deviceSize.height * 0.43,
                                          // width: 420,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                  // ),
                  // height: deviceSize.height,
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Text("Order"),
      // )
    );
  }
}

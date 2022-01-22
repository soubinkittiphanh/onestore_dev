import 'dart:developer';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:onestore/models/cart.dart';
import 'package:onestore/models/product.dart';

class CartController extends GetxController {
  final List<CartItem> _cartItem = [];
  void addCart(Product pro, int qty) {
    if (_cartItem.isEmpty) {
      _cartItem.add(CartItem(
        proId: pro.proId,
        qty: qty,
        price: pro.proPrice,
        priceTotal: pro.proPrice,
        priceRetail: pro.proPrice - (pro.proPrice * pro.retailPrice / 100),
      ));
      update();
      log("Empty");
    } else {
      log("product id: " + pro.proId.toString());
      CartItem existProduct = _cartItem.firstWhere(
        (element) => element.proId == pro.proId,
        orElse: () => CartItem(
            proId: 0, qty: 0, price: 0.00, priceTotal: 0.00, priceRetail: 0.00),
      );
      log("exist product id: " + existProduct.proId.toString());
      if (existProduct.proId <= 0) {
        //there is not exist product in the cart
        _cartItem.add(CartItem(
            proId: pro.proId,
            qty: qty,
            price: pro.proPrice,
            priceTotal: pro.proPrice,
            priceRetail:
                pro.proPrice - (pro.proPrice * pro.retailPrice / 100)));
        update();
        log("Not empty and not exist");
      } else {
        CartItem updateProduct = CartItem(
          proId: pro.proId,
          qty: existProduct.qty + qty,
          price: existProduct.price,
          priceTotal: pro.proPrice * (existProduct.qty + qty),
          priceRetail: existProduct.priceRetail,
        );
        _cartItem
            .removeWhere((element) => element.proId == updateProduct.proId);
        _cartItem.add(updateProduct);

        update();
        log("Not empty and exist");
      }
    }
    log("Add...");
  }

  void removeOneCart(Product pro) {
    CartItem existProduct =
        _cartItem.firstWhere((element) => element.proId == pro.proId,
            orElse: () => CartItem(
                  proId: 0,
                  qty: 0,
                  price: 0.00,
                  priceTotal: 0.00,
                  priceRetail: 0.00,
                ));
    log(
      "exist product id: " +
          existProduct.proId.toString() +
          " price " +
          existProduct.price.toString(),
    );

    CartItem updateProduct = CartItem(
      proId: pro.proId,
      qty: existProduct.qty - 1,
      price: existProduct.price,
      priceTotal: pro.proPrice * (existProduct.qty - 1),
      priceRetail: existProduct.priceRetail,
    );
    _cartItem.removeWhere((element) => element.proId == updateProduct.proId);
    _cartItem.add(updateProduct);

    update();
    log("Not empty and exist");
  }

  void removeCart(int id) {
    _cartItem.removeWhere((element) => element.proId == id);
    log("remove... ");
    update();
  }

  void clearCartItem() {
    _cartItem.clear();
    update();
  }

  List<CartItem> get cartItem {
    return [..._cartItem];
  }

  CartItem cartItemId(id) {
    return _cartItem.firstWhere((element) => element.proId == id);
  }

  int get cartCount {
    return _cartItem.length;
  }

  double get cartCost {
    double total = 0;
    for (var element in _cartItem) {
      total += element.priceTotal;
    }
    return total;
  }
}

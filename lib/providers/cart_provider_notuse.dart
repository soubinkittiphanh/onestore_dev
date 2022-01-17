import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:onestore/models/cart.dart';
import 'package:onestore/models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItem = [];
  void addCart(Product pro) {
    if (_cartItem.isEmpty) {
      _cartItem.add(CartItem(pro.proId, 1, pro.proPrice, pro.proPrice));
      notifyListeners();
      log("Empty");
    } else {
      log("product id: " + pro.proId.toString());
      CartItem existProduct = _cartItem.firstWhere(
          (element) => element.proId == pro.proId,
          orElse: () => CartItem(0, 0, 0.00, 0.00));
      log("exist product id: " + existProduct.proId.toString());
      if (existProduct.proId <= 0) {
        //there is not exist product in the cart
        _cartItem.add(CartItem(pro.proId, 1, pro.proPrice, pro.proPrice));
        notifyListeners();
        log("Not empty and not exist");
      } else {
        CartItem updateProduct = CartItem(
          pro.proId,
          existProduct.qty + 1,
          existProduct.price,
          pro.proPrice * (existProduct.qty + 1),
        );
        _cartItem
            .removeWhere((element) => element.proId == updateProduct.proId);
        _cartItem.add(updateProduct);

        notifyListeners();
        log("Not empty and exist");
      }
    }
    log("Add...");
  }

  void removeOneCart(Product pro) {
    CartItem existProduct = _cartItem.firstWhere(
        (element) => element.proId == pro.proId,
        orElse: () => CartItem(0, 0, 0.00, 0.00));
    log(
      "exist product id: " +
          existProduct.proId.toString() +
          " price " +
          existProduct.price.toString(),
    );

    CartItem updateProduct = CartItem(
      pro.proId,
      existProduct.qty - 1,
      existProduct.price,
      pro.proPrice * (existProduct.qty - 1),
    );
    _cartItem.removeWhere((element) => element.proId == updateProduct.proId);
    _cartItem.add(updateProduct);

    notifyListeners();
    log("Not empty and exist");
  }

  void removeCart(int id) {
    _cartItem.removeWhere((element) => element.proId == id);
    log("remove... ");
    notifyListeners();
  }

  void clearCartItem() {
    _cartItem.clear();
    notifyListeners();
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

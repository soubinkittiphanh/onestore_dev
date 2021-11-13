import 'package:flutter/material.dart';
import 'package:onestore/models/cart.dart';

class ProvCart extends ChangeNotifier {
  final List<CartItem> cartItem = [];
  List<CartItem> get getCartItem {
    return [...cartItem];
  }

  void addCart(proId) {
    var existData = cartItem.firstWhere((element) => element.proId == proId);
    if (existData.proId <= 0) {
      var newItem = CartItem(existData.proId, existData.qty + 1,
          existData.price, existData.price * (existData.qty + 1));
      cartItem.add(newItem);
      notifyListeners();
      return;
    }
    cartItem.add(CartItem(proId, 1, 2000, 20000));
  }
}

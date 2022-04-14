import 'dart:developer';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:onestore/models/product.dart';
import 'package:onestore/models/product_category.dart';

class ProductController extends GetxController {
  List<Product> _product = [];
  List<ProductCatetory> _productCategory = [];
  // var counterNum = 0.obs;
  void addProduct(List<Product> loadData) {
    _product = [...loadData];
    update();
  }

  void addProductCategory(List<ProductCatetory> loadData) {
    _productCategory = [...loadData];
    update();
  }

  List<Product> get product {
    return [..._product];
  }

  List<ProductCatetory> get productCategory {
    return [..._productCategory];
  }

  Product productId(id) {
    log("Product id: " + id.toString());
    final product = _product.firstWhere((el) => el.proId == id);
    log("Product len: => " + product.categName);
    return product;
  }
}

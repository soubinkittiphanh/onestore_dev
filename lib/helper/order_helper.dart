import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:onestore/config/host_con.dart';
import 'package:onestore/models/cart.dart';
import 'package:http/http.dart' as http;
import 'package:onestore/models/order.dart';
import 'dart:convert' as convert;

class OrderHelper {
  static List<Order> _orderItem = [];
  static Future<String> sendOrder(List<CartItem> cart, userId, token) async {
    final url = Uri.parse(hostname + "order_i");
    log("cart: $cart");
    var response = await http.post(
      url,
      body: json.encode({
        "cart_data": cart,
        "user_id": userId,
      }),
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer " + token,
      },
    );
    log("response: ${response.statusCode}");
    if (response.statusCode == 200) {
      //connection succeed
      log("Transaction completed");
      log("message server: " + response.body);
    } else {
      //connection fail
      log("Transactino fail");
      log("ERROR: " + response.body);
    }

    return response.body;
  }

  static Future<List<Order>> fetchOrder(userId, dateF, dateT) async {
    var request = Uri.parse(hostname + "order_f").resolveUri(
      Uri(
        queryParameters: {
          "f_date": DateFormat('yyyy-MM-dd').format(dateF),
          "t_date": DateFormat('yyyy-MM-dd').format(dateT),
          "mem_id": userId,
        },
      ),
    );
    // final url = Uri.parse(hostname+ '/order_f/?mem_id=1000');
    var response = await http.get(request);
    if (response.statusCode == 200) {
      log("Transaction completed");
      log("ERROR: " + response.body);
      var jsonResponse = convert.jsonDecode(response.body) as List;
      _orderItem = jsonResponse
          .map(
            (el) => Order(
              el["order_id"].toString(),
              el["txn_date"],
              el["user_id"],
              el["product_id"],
              el["product_amount"],
              double.parse((el["product_price"]).toString()),
              double.parse(el["order_price_total"].toString()),
              el["pro_name"],
              double.parse(el["product_discount"].toString()),
            ),
          )
          .toList();
      return _orderItem;
    } else {
      log("Transaction fail");
      log("ERROR: " + response.body);
      return _orderItem;
    }
    // return "aa";
  }

  static Future<List<Order>> fetchMaxOrder(userId) async {
    var request = Uri.parse(hostname + "max_order_f").resolveUri(
      Uri(
        queryParameters: {
          "mem_id": userId,
        },
      ),
    );
    // final url = Uri.parse(hostname+ '/order_f/?mem_id=1000');
    var response = await http.get(request);
    if (response.statusCode == 200) {
      log("Transaction completed");
      var jsonResponse = convert.jsonDecode(response.body) as List;
      _orderItem = jsonResponse
          .map(
            (el) => Order(
              el["order_id"].toString(),
              el["txn_date"],
              el["user_id"],
              el["product_id"],
              el["product_amount"],
              double.parse((el["product_price"]).toString()),
              double.parse(el["order_price_total"].toString()),
              el["pro_name"],
              double.parse(el["product_discount"].toString()),
            ),
          )
          .toList();
      return _orderItem;
    } else {
      log("Transaction fail");
      log("ERROR: " + response.body);
      return _orderItem;
    }
    // return "aa";
  }
}

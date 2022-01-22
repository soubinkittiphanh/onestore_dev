import 'dart:developer';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:onestore/models/order.dart';

class OrderController extends GetxController {
  final f = NumberFormat("#,###");
  List<Order> _orderItem = [];
  List<Order> get orderItem {
    return [..._orderItem];
  }

  List<Order> orderItemId(id) {
    var groupOfOrder = _orderItem.where((element) => element.orderId == id);
    return [...groupOfOrder];
  }

  String orderTotalPriceById(id) {
    double total = 0;
    for (var el in orderItemId(id)) {
      total += el.total;
    }
    // return total.toString();
    return f.format(total);
  }

  double get orderTotalPrice {
    double total = 0;
    for (var el in _orderItem) {
      total += el.total;
    }
    return total;
  }

  List<Order> get orderItemNotDuplicate {
    List<Order> _orderItemNotDuplicate = [];
    // var i = 0;
    for (var element in _orderItem) {
      // i++;
      // log("message" + i.toString());
      if (_orderItemNotDuplicate
              .indexWhere((el) => el.orderId == element.orderId) >=
          0) {
        // log("remove");
        log(_orderItemNotDuplicate
            .indexWhere((el) => el.orderId == element.orderId)
            .toString());
      } else {
        // log("add");
        _orderItemNotDuplicate.add(element);
      }
    }
    // log("not duplicate: " + _orderItemNotDuplicate.length.toString());
    return [..._orderItemNotDuplicate];
  }

  void setOrderItem(List<Order> order) {
    _orderItem = [...order];
    update();
  }
}

import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:loader_overlay/loader_overlay.dart';

import 'package:onestore/getxcontroller/order_controller.dart';
import 'package:onestore/getxcontroller/user_info_controller.dart';
import 'package:onestore/helper/order_helper.dart';
import 'package:onestore/models/order.dart';

import 'package:onestore/widgets/order/order_report_header.dart';
import 'package:onestore/widgets/order_item.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderOverviewScreen extends StatefulWidget {
  const OrderOverviewScreen({Key? key}) : super(key: key);

  @override
  State<OrderOverviewScreen> createState() => _OrderOverviewScreenState();
}

class _OrderOverviewScreenState extends State<OrderOverviewScreen> {
  DateTime _selectedDateFrom = DateTime.now();
  DateTime _selectedDateTo = DateTime.now();
  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    final orderController = Get.put(OrderController());
    final userInfoController = Get.put(UserInfoController());
    List<Order> loadOrder = orderController.orderItemNotDuplicate;
    Future<void> orderFetch(_selectedDateFrom, _selectedDateTo) async {
      log("loading...");
      // context.loaderOverlay.show();

      loadOrder = await OrderHelper.fetchOrder(
          userInfoController.userId, _selectedDateFrom, _selectedDateTo);
      setState(() {
        orderController.setOrderItem(loadOrder);
      });
      // context.loaderOverlay.hide();
    }

    void _onRefresh() async {
      // monitor network fetch

      await orderFetch(_selectedDateFrom, _selectedDateTo);

      log("on refresh");
      setState(() {});
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      // monitor network fetch
      log("on loading");
      // await Future.delayed(Duration(milliseconds: 1000));

      setState(() {});
      _refreshController.loadComplete();
    }

    void presentDatePicker(String dateFromOrTo) {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) {
          log("Null date");
          return;
        }
        log("Setstate: " + pickedDate.toString());
        setState(() {
          dateFromOrTo.contains("f")
              ? _selectedDateFrom = pickedDate
              : _selectedDateTo = pickedDate;
        });
        log("New date: " + _selectedDateFrom.toString());
      });
    }

    return LoaderOverlay(
      child: Center(
        child: SmartRefresher(
          enablePullDown: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: orderController.orderItemNotDuplicate.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      OrderReportHead(
                          presentDatePicker: presentDatePicker,
                          orderFetch: orderFetch,
                          selectedDateFrom: _selectedDateFrom,
                          selectedDateTo: _selectedDateTo),
                      Image.asset(
                        'asset/images/waiting.png',
                        height: 200,
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    OrderReportHead(
                        presentDatePicker: presentDatePicker,
                        orderFetch: orderFetch,
                        selectedDateFrom: _selectedDateFrom,
                        selectedDateTo: _selectedDateTo),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (ctx, id) => Card(
                          child: OrderItem(
                              loadOrder:
                                  orderController.orderItemNotDuplicate[id]),
                        ),
                        itemCount: orderController.orderItemNotDuplicate.length,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onestore/getxcontroller/order_controller.dart';
import 'package:onestore/getxcontroller/user_info_controller.dart';
import 'package:onestore/helper/order_helper.dart';
import 'package:onestore/models/order.dart';
import 'package:onestore/widgets/order_item.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderOverviewScreen extends StatefulWidget {
  const OrderOverviewScreen({Key? key}) : super(key: key);

  @override
  State<OrderOverviewScreen> createState() => _OrderOverviewScreenState();
}

class _OrderOverviewScreenState extends State<OrderOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    final f = NumberFormat("#,###");
    final orderController = Get.put(OrderController());
    // final userCredProvider = Provider.of<UserCredentialProvider>(context);
    final userInfoController = Get.put(UserInfoController());
    List<Order> loadOrder = orderController.orderItemNotDuplicate;
    Future<void> orderFetch() async {
      log("loading...");
      // context.loaderOverlay.show();

      loadOrder = await OrderHelper.fetchOrder(userInfoController.userId);
      orderController.setOrderItem(loadOrder);
      // context.loaderOverlay.hide();
    }

    void _onRefresh() async {
      // monitor network fetch

      await orderFetch();

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

    // orderFetch();

    return LoaderOverlay(
      child: Center(
          child: SmartRefresher(
        enablePullDown: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: orderController.orderItemNotDuplicate.isEmpty
            ? Center(
                child: Image.asset(
                  'asset/images/waiting.png',
                  height: 200,
                ),
              )
            : ListView.builder(
                itemBuilder: (ctx, id) => Card(
                  child: OrderItem(
                      loadOrder: orderController.orderItemNotDuplicate[id]),
                ),
                itemCount: orderController.orderItemNotDuplicate.length,
              ),
      )),
    );
  }
}

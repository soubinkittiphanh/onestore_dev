import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:onestore/config/host_con.dart';
import 'package:onestore/helper/order_helper.dart';
import 'package:onestore/models/order.dart';
import 'package:onestore/providers/order_provider.dart';
import 'package:onestore/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrderOverviewScreen extends StatelessWidget {
  const OrderOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    List<Order> loadOrder = orderProvider.orderItemNotDuplicate;
    Future<void> orderFetch() async {
      log("loading...");

      loadOrder = await OrderHelper.fetchOrder;
      orderProvider.setOrderItem(loadOrder);
    }

    return Container(
      // color: Colors.red,
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "ຍອດຊື້ສະສົມ: ${NumFormater.format(orderProvider.orderTotalPrice)} ກີບ",
                  style: Theme.of(context).textTheme.headline6,
                ),
                TextButton(
                  child: Text(
                    "ທັງຫມົດ: ${loadOrder.length} ອໍເດິ້",
                    // style: Theme.of(context).textTheme.bodyText2,
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: 'Noto San Lao',
                        fontStyle: FontStyle.normal,
                        color: Colors.white),
                  ),
                  onPressed: orderFetch,
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                itemBuilder: (ctx, id) => Card(
                  child: OrderItem(loadOrder: loadOrder[id]),
                ),
                itemCount: loadOrder.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

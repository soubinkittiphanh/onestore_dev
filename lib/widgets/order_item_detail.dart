import 'package:flutter/material.dart';
import 'package:onestore/getxcontroller/order_controller.dart';
import 'package:get/get.dart';

class OrderItemDetail extends StatelessWidget {
  const OrderItemDetail({
    Key? key,
    required this.orderId,
  }) : super(key: key);
  final orderId;
  @override
  Widget build(BuildContext context) {
    final oderController = Get.put(OrderController());
    final orderDetail = oderController.orderItemId(orderId);
    return Column(
      children: [
        const Divider(
          height: 1,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, id) => ListTile(
              title: Text(
                "${orderDetail[id].prodId} | ${orderDetail[id].proName}",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              subtitle: Text("${orderDetail[id].price}"),
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.red,
                child: CircleAvatar(
                  radius: 23.5,
                  backgroundColor: Colors.white,
                  child: Text("x ${orderDetail[id].qty}"),
                ),
              ),
            ),
            itemCount: orderDetail.length,
          ),
        ),
      ],
    );
  }
}

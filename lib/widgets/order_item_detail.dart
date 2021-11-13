import 'package:flutter/material.dart';
import 'package:onestore/providers/order_provider.dart';
import 'package:provider/provider.dart';

class OrderItemDetail extends StatelessWidget {
  const OrderItemDetail({
    Key? key,
    required this.orderId,
  }) : super(key: key);
  final orderId;
  @override
  Widget build(BuildContext context) {
    final orderDetail =
        Provider.of<OrderProvider>(context).orderItemId(orderId);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, id) => ListTile(
              title: Text(
                "${orderDetail[id].prodId} | ${orderDetail[id].proName}",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              subtitle: Text("${orderDetail[id].price}"),
              leading: CircleAvatar(
                child: Text("x ${orderDetail[id].qty}"),
              ),
            ),
            itemCount: orderDetail.length,
          ),
        ),
      ],
    );
  }
}

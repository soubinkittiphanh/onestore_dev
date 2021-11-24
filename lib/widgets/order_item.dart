import 'package:flutter/material.dart';
import 'package:onestore/models/order.dart';
import 'package:onestore/providers/order_provider.dart';
import 'package:provider/provider.dart';

import 'order_item_detail.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({
    Key? key,
    required this.loadOrder,
  }) : super(key: key);

  final Order loadOrder;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isexpand = false;

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ລະຫັດອໍເດີ: ${widget.loadOrder.orderId} ", //| ວັນທີ: ${widget.loadOrder.orderDate.substring(0, 10)} ${widget.loadOrder.orderDate.substring(11, 19)}",
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                "ວັນທີ: ${widget.loadOrder.orderDate.substring(0, 10)} ${widget.loadOrder.orderDate.substring(11, 19)}",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "ລາຄາລວມ: ${orderProvider.orderTotalPriceById(widget.loadOrder.orderId)}",
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                isexpand = !isexpand;
              });
            },
            icon: Icon(
              isexpand
                  ? Icons.expand_less_outlined
                  : Icons.expand_more_outlined,
            ),
          ),
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          firstChild: Container(
            child: OrderItemDetail(orderId: widget.loadOrder.orderId),
            height: 160,
            width: double.infinity,
            // color: Colors.white,
          ), // When you don't want to show menu..
          secondChild: Container(),
          crossFadeState:
              isexpand ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        )
      ],
    );
  }
}

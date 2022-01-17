import 'package:flutter/material.dart';

class CartOverviewAction extends StatelessWidget {
  const CartOverviewAction({
    Key? key,
    required this.pageChange,
    required this.placeOrder,
  }) : super(key: key);
  final Function pageChange;
  final Function placeOrder;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Row(children: [
          RaisedButton(
            onPressed: () {
              pageChange(0);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: const EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.purple],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                constraints:
                    const BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: const Text(
                  "ເລືອກສິນຄ້າຕໍ່",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "noto san lao",
                  ),
                ),
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              placeOrder();
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: const EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.purple],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                constraints:
                    const BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: const Text(
                  "ສັ່ງຊື້ເລີຍ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "noto san lao",
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

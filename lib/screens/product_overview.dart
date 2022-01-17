import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:onestore/models/product.dart';
import 'package:onestore/service/advertise.dart';
import 'package:onestore/widgets/category.dart';
import 'package:onestore/widgets/compo_product_item.dart';
import 'package:onestore/widgets/product_comp/compo_product_detail.dart';

class ProductOverview extends StatefulWidget {
  final List<Product> demoProducts;
  const ProductOverview(
      {Key? key,
      required this.demoProducts,
      required this.pageChange,
      required this.catChange})
      : super(key: key);
  final Function pageChange;
  final Function catChange;
  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // simply use this
    Timer.run(() {
      log("ad: " + Ad.isActive.toString());
      if (Ad.isactive == 1) {
        Ad.disableAd();

        showDialog(
          context: context,
          builder: (_) {
            return Platform.isIOS
                ? Ad.showInfoDialogIos(context)
                : Ad.showInfoDialogAndroid(context);
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Category(catChange: widget.catChange),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 170,
                childAspectRatio: 1 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: widget.demoProducts.length,
              itemBuilder: (context, idx) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ProductDetailComp(
                          product: widget.demoProducts[idx],
                          pageChange: widget.pageChange),
                    ),
                  );
                },
                child: CompProductItem(
                  proName: widget.demoProducts[idx].proName,
                  pro: widget.demoProducts[idx],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

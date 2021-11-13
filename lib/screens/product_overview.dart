import 'package:flutter/material.dart';
import 'package:onestore/models/product.dart';
// import 'package:onestore/models/product_temp.dart';
import 'package:onestore/widgets/category.dart';
import 'package:onestore/widgets/compo_product_item.dart';

class ProductOverview extends StatelessWidget {
  final List<Product> demoProducts;
  const ProductOverview({Key? key, required this.demoProducts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Category(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 170,
                childAspectRatio: 1 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: demoProducts.length,
              itemBuilder: (context, idx) => CompProductItem(
                proName: demoProducts[idx].proName,
                pro: demoProducts[idx],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

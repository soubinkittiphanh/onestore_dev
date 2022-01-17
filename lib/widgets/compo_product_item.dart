import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onestore/models/product.dart';
import 'package:onestore/widgets/product_comp/compo_action_bar.dart';

class CompProductItem extends StatelessWidget {
  final String proName;
  final Product pro;
  const CompProductItem({Key? key, required this.proName, required this.pro})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final f = NumberFormat("#,###");
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(children: [
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: pro.proImagePath.contains("No image")
                    ? const Text("No image")
                    : CachedNetworkImage(
                        imageUrl: pro.proImagePath,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) {
                          log("IMAGE ER: " + error.toString());
                          return const Icon(Icons.error);
                        },
                      ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1, color: Colors.red),
              ),
            ),
            CompoActionBar(
              product: pro,
              // ctx: context,
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Text(
              pro.proName,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Text('ລາຄາ: ${f.format(pro.proPrice)}')
      ],
    );
  }
}

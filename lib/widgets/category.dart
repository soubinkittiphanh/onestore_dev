import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onestore/getxcontroller/product_controller.dart';

class Category extends StatefulWidget {
  final Function catChange;
  const Category({Key? key, required this.catChange}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final proCategory = Get.put(ProductController());
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent,
            offset: Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.5,
            spreadRadius: -1.0,
          ), //BoxShadow
        ],
      ),
      height: 50,
      child: GetBuilder<ProductController>(builder: (ctr) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:
              proCategory.productCategory.length, //    categoryItem.length,
          itemBuilder: (context, idx) => buildCategoryItem(idx),
        );
      }),
    );
  }

  Widget buildCategoryItem(int idx) {
    return GestureDetector(
      onTap: () {
        widget.catChange(proCategory.productCategory[idx].catCode);
        setState(() {
          _selectedIndex = idx;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(proCategory.productCategory[idx].catName),
            Container(
              margin: const EdgeInsets.only(top: 10 / 4),
              height: 2,
              width: 30,
              color:
                  _selectedIndex == idx ? Colors.black45 : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}

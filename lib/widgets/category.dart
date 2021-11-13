import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<String> categoryItem = [
    'Pubg',
    'Freefire',
    'Mobile legen',
    'Long hed',
    'Call of duty',
    'Footbal',
    'Canadian',
    'Electronic'
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryItem.length,
        itemBuilder: (context, idx) => buildCategoryItem(idx),
      ),
    );
  }

  Widget buildCategoryItem(int idx) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = idx;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(categoryItem[idx]),
            Container(
              margin: EdgeInsets.only(top: 10 / 4),
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

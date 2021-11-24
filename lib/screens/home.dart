import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onestore/helper/product_helper.dart';
import 'package:onestore/models/product.dart';
import 'package:onestore/providers/cart_provider.dart';
import 'package:onestore/providers/inbox_message_provider.dart';
import 'package:onestore/providers/product_provider.dart';
import 'package:onestore/screens/favourite_screen.dart';
import 'package:onestore/screens/inbox_screen.dart';
import 'package:onestore/screens/product_overview.dart';
import 'package:onestore/screens/profile_screen.dart';
import 'package:provider/provider.dart';

import 'cart_overview.dart';
import 'order_overview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final inboxProvider = Provider.of<InboxMessageProvider>(context);
    List<Product> _loadProduct = productProvider.product;
    final PageController _pageController = PageController(
      initialPage: _selectedPage,
    );
    void _pageChange(v) {
      setState(() {
        _selectedPage = v;
      });
    }

    void _bottomBarChange(idx) {
      setState(() {
        _pageController.animateToPage(idx,
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
      });
    }

    void _getDataFromHttp() async {
      context.loaderOverlay.show();
      _loadProduct = await ProductHelper.fetchProcuctAPI();
      productProvider.addProduct(_loadProduct);
      context.loaderOverlay.hide();
    }

    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Text("${cartProvider.cartItem.length}"),
            const IconButton(
              onPressed: null,
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: _getDataFromHttp,
              icon: const Icon(Icons.download),
            )
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _pageChange,
          children: [
            ProductOverview(
              demoProducts: _loadProduct,
            ),
            const CartOverview(),
            const OrderOverviewScreen(),
            const FavouriteSreen(),
            const InboxScreen(),
            const ProfileScreen(),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: _selectedPage,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.bounceInOut,
          animationDuration: const Duration(milliseconds: 200),
          height: 50,
          items: <Widget>[
            const Icon(
              Icons.shopping_bag,
              size: 20,
              color: Colors.white,
            ),
            Column(
              children: [
                CircleAvatar(
                  child: Text('${cartProvider.cartItem.length}'),
                  backgroundColor: Colors.white,
                  // backgroundColor: _selectedPage == 1 ? Colors.white : null,
                ),
                const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
            const Icon(
              Icons.production_quantity_limits,
              size: 20,
              color: Colors.white,
            ),
            const Icon(
              Icons.favorite,
              size: 20,
              color: Colors.white,
            ),
            Column(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: CircleAvatar(
                    radius: 19.7,
                    backgroundColor: Colors.white,
                    child: Text(
                      inboxProvider.ureadMessage.toString(),
                    ),
                  ),
                ),
                const Icon(
                  Icons.messenger_outline,
                  size: 20,
                  color: Colors.white,
                ),
              ],
            ),
            const Icon(
              Icons.person,
              size: 20,
              color: Colors.white,
            ),
          ],
          onTap: _bottomBarChange,
          color: Colors.redAccent,
          // buttonBackgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

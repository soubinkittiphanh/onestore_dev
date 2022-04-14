import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onestore/config/host_con.dart';
import 'package:onestore/getxcontroller/message_controller.dart';
import 'package:onestore/getxcontroller/order_controller.dart';
import 'package:onestore/getxcontroller/product_controller.dart';
import 'package:onestore/getxcontroller/user_info_controller.dart';
import 'package:onestore/getxcontroller/wallet_txn_controller.dart';
import 'package:onestore/models/product.dart';
import 'package:onestore/screens/contact_us.dart';
import 'package:onestore/screens/message_overview_screen.dart';
import 'package:onestore/screens/product_overview.dart';
import 'package:onestore/screens/profile_screen.dart';
import 'package:onestore/service/bank_service.dart';
import 'package:onestore/service/inquiry_type_service.dart';
import 'package:onestore/service/message_service.dart';
import 'package:onestore/service/order_service.dart';
import 'package:onestore/service/product_service.dart';
import 'package:onestore/service/wallet_txn_service.dart';
import 'package:onestore/widgets/main_drawer.dart';
import 'package:get/get.dart';
import 'order_overview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String category = "";
  final productContr = Get.put(ProductController());
  final userInfoController = Get.put(UserInfoController());
  final productService = ProductService();
  final messageController = Get.put(MessageController());
  final orderController = Get.put(OrderController());

  int _selectedPage = 0;
  @override
  void initState() {
    productService.loadProduct();
    productService.loadProductCategory();
    InquiryTypeService.initChatType();
    WalletTxnService.loadTxn(userInfoController.userId);
    OrderService.loadOrder(userInfoController.userId);
    MessageService.loadMessage(
        userInfoController.userId, userInfoController.userName);
    BankService.loadBank();

    super.initState();
  }

  List<Product> _filterProductByCategory() {
    return category.isEmpty || category.contains("all")
        ? productContr.product
        : productContr.product.where((element) {
            log("Element cat: " + element.proCategory);
            log("Is true: " + element.proCatID.contains(category).toString());
            return element.proCatID.contains(category);
          }).toList();
  }

  _categoryChange(String cat) {
    setState(() {
      category = cat;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final userCreProvider = Provider.of<UserCredentialProvider>(context);
    final walletController = Get.put(WalletTxnController());

    // List<Order> loadOrder = orderController.orderItemNotDuplicate;
    final PageController _pageController = PageController(
      initialPage: _selectedPage,
    );

    void _bottomBarChange(idx) {
      setState(() {
        _pageController.animateToPage(idx,
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
      });
    }

    void _pageChange(v) {
      log("PAGE: " + v.toString());
      setState(() {
        _selectedPage = v;
      });
    }

    void _pageChangeModel(v) {
      log("PAGE: " + v.toString());
      setState(() {
        _selectedPage = v;
      });
      _bottomBarChange(v);
    }

    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.account_balance_wallet),
                const SizedBox(
                  width: 10,
                ),
                GetBuilder<WalletTxnController>(builder: (ctr) {
                  return Text(
                    numFormater.format(ctr.totalCR - walletController.totalDR),
                  );
                }),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      WalletTxnService.loadTxn(userInfoController.userId);
                    },
                    icon: const Icon(Icons.refresh))
              ],
            ),
          ],
        ),
        drawer: MainDrawer(
          fuctionOntap: [
            _bottomBarChange,
            _bottomBarChange,
            _bottomBarChange,
            _bottomBarChange,
            _bottomBarChange
          ],
          catChange: _categoryChange,
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _pageChange,
          children: [
            GetBuilder<ProductController>(builder: (_) {
              return ProductOverview(
                demoProducts: _filterProductByCategory(),
                pageChange: _pageChangeModel,
                catChange: _categoryChange,
              );
            }),
            // CartOverview(
            //   pageChange: _pageChangeModel,
            // ),
            const OrderOverviewScreen(),
            // const FavouriteSreen(),
            const ContactUs(),
            const InboxOverivewScreen(),
            const ProfileScreen(),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: _selectedPage,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.bounceInOut,
          animationDuration: const Duration(milliseconds: 200),
          height: 60,
          items: <Widget>[
            const Icon(
              Icons.shopping_bag,
              size: 20,
              color: Colors.white,
            ),
            // Column(
            //   children: [
            //     GetBuilder<CartController>(builder: (ctr) {
            //       return CircleAvatar(
            //         child: Text('${cartProvider.cartItem.length}'),
            //         backgroundColor: Colors.white,
            //         // backgroundColor: _selectedPage == 1 ? Colors.white : null,
            //       );
            //     }),
            //     const Icon(
            //       Icons.shopping_cart,
            //       color: Colors.white,
            //       size: 20,
            //     ),
            //   ],
            // ),
            const Icon(
              Icons.calendar_today,
              size: 20,
              color: Colors.white,
            ),
            const Icon(
              Icons.attach_money_outlined,
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
                      messageController.unreadMessage.toString(),
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

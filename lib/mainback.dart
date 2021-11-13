import 'package:flutter/material.dart';
import 'package:onestore/providers/cart_provider.dart';
import 'package:onestore/providers/order_provider.dart';
import 'package:onestore/providers/product_provider.dart';
import 'package:onestore/screens/login_screen.dart';
import 'package:onestore/screens/register_email.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: const TextTheme(
          caption: TextStyle(
              fontSize: 16,
              fontFamily: 'Noto San Lao',
              color: Colors.yellowAccent),
          headline1: TextStyle(
            fontSize: 72,
            fontFamily: 'Noto San Lao',
            fontWeight: FontWeight.bold,
          ),
          headline5: TextStyle(
            fontSize: 24,
            fontFamily: 'Noto San Lao',
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
          headline6: TextStyle(
            fontSize: 20,
            fontFamily: 'Noto San Lao',
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
          bodyText2: TextStyle(
            fontSize: 14,
            fontFamily: 'Noto San Lao',
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
          bodyText1: TextStyle(
            fontSize: 24,
            fontFamily: 'Noto San Lao',
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => CartProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => ProductProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => OrderProvider(),
          ),
        ],
        child: const LoginScreen(),
        // child: const MyHomePage(title: 'ຮ້ານຂາຍບັດອອນລາຍ'),
      ),
      routes: {
        RegistEmailScreen.routerName: (ctx) => RegistEmailScreen(),
      },
    );
  }
}

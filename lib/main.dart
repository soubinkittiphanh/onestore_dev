import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onestore/providers/cart_provider.dart';
import 'package:onestore/providers/inbox_message_provider.dart';
import 'package:onestore/providers/order_provider.dart';
import 'package:onestore/providers/product_provider.dart';
import 'package:onestore/providers/user_credental_provider.dart';
import 'package:onestore/screens/login_screen.dart';
import 'package:onestore/screens/register_email.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        ChangeNotifierProvider(
          create: (ctx) => userCredentailProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => InboxMessageProvider(),
        ),
      ],
      child: MaterialApp(
        title: "OneStore",
        theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: const TextTheme(
            caption: TextStyle(
              fontSize: 16,
              fontFamily: 'Noto San Lao',
            ),
            headline1: TextStyle(
              fontSize: 72,
              fontFamily: 'Noto San Lao',
              fontWeight: FontWeight.bold,
            ),
            headline5: TextStyle(
              fontSize: 24,
              fontFamily: 'Noto San Lao',
              fontStyle: FontStyle.normal,
              // color: Colors.white,
            ),
            headline6: TextStyle(
              fontSize: 20,
              fontFamily: 'Noto San Lao',
              fontStyle: FontStyle.normal,
              // color: Colors.white,
            ),
            bodyText2: TextStyle(
              fontSize: 14,
              fontFamily: 'Noto San Lao',
              fontStyle: FontStyle.normal,
              // color: Colors.white,
            ),
            bodyText1: TextStyle(
              fontSize: 24,
              fontFamily: 'Noto San Lao',
              fontStyle: FontStyle.normal,
              // color: Colors.white,
            ),
          ),
        ),
        home: LoginScreen(),
        routes: {
          RegistEmailScreen.routerName: (ctx) => RegistEmailScreen(),
        },
      ),
    );
  }
}

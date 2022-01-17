import 'package:flutter/material.dart';
import 'package:onestore/screens/login_screen.dart';
import 'package:onestore/screens/register_email.dart';

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
      home: const LoginScreen(),
      routes: {
        RegistEmailScreen.routerName: (ctx) => const RegistEmailScreen(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_supplier/Pages/login.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '商品砼手机ERP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          platform: TargetPlatform.android, primaryColor: Colors.blue),
      routes: {
        '/': (context) => LoginPage(),
      },
    );
  }
}
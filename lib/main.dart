import 'package:flutter/material.dart';
import 'package:nsostock/routers.dart';
import 'package:nsostock/themes/style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: '/onboarding',
      routes: routes,
    );
  }
}
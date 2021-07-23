import 'package:flutter/material.dart';
import 'package:nsostock/routers.dart';
import 'package:nsostock/themes/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

var storeStep;
var initURL;

void main() async {

  // กำหนดให้สามารถเรียก Widget จากภายนอกได้
  WidgetsFlutterBinding.ensureInitialized();

  // อ่านค่าจาก Sharepreferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  storeStep = sharedPreferences.getInt('storeStep');

  if(storeStep == 1){
    initURL = '/dashboard';
  }else if(storeStep == 2){
    initURL = '/login';
  }else{
    initURL = '/onboarding';
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: initURL,
      routes: routes,
    );
  }
}
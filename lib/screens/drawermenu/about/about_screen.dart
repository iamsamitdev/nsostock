import 'package:flutter/material.dart';
import 'package:nsostock/utils/constants.dart';

class AboutScreen extends StatefulWidget {
  AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(about_menu_text),
      ),
      body: Center(
        child: Text('รายละเอียด'+about_menu_text),
      ),
    );
  }
}